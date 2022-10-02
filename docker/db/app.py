import json
import apsw
import boto3
import sqlite_s3vfs

def handler(event, context):
    


    # A boto3 bucket resource
    bucket = boto3.Session().resource('s3').Bucket('djembe-db-bucket')

    # An S3VFS for that bucket
    s3vfs = sqlite_s3vfs.S3VFS(bucket=bucket)

    # sqlite-s3vfs stores many objects under this prefix
    # Note that it's not typical to start a key prefix with '/'
    key_prefix = 'build.db'

    # Connect, insert data, and query
    with apsw.Connection(key_prefix, vfs=s3vfs.name) as db:
        cursor = db.cursor()
        cursor.execute('''
            CREATE TABLE foo(x,y);
            INSERT INTO foo VALUES(1,2);
        ''')
        cursor.execute('SELECT * FROM foo;')
        output = cursor.fetchall()
        print(output)
    return {
        'statusCode': 200,
        'body': json.dumps(f'Hello from Lambda! DB test output: {output}')
    }
