output "db_bucket_id" {
  value = module.s3.db_bucket_id
}

output "db_user_access_key" {
  value = module.iam.db_user_access_key
}


output "db_user_secret_key" {
  value = module.iam.db_user_secret_key
  sensitive = true
}