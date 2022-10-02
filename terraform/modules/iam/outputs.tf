output "db_user_access_key" {
  value = aws_iam_access_key.db.id
}

output "db_user_secret_key" {
  value = aws_iam_access_key.db.secret
}