variable "region" {
  type = "string"
  description = "The AWS region you want to use for s3 and dynamodb"
  default = "eu-west-1"
}

variable "state_name" {
  type = "string"
  description = "Name which is used for S3 bucket and dynamodb table"
}