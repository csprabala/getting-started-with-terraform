output "s3_bucket_arn" {
  value       = aws_s3_bucket.terraform_state.arn
  description = "The ARN on the s3 bucket storing terraform state"

}

output "dynamo_db_table_name" {
  value       = aws_dynamodb_table.terraform_locks.name
  description = "The name of the dynamo db table"
}
