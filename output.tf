output "s3_bucket" {
  value = "${local.s3_bucket_name}"
}
output "dynamodb_table" {
  value = "${local.dynamodb_table_name}"
}
output "aws_region" {
 value = "${var.region}" 
}