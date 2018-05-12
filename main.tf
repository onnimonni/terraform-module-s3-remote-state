# Convert typical non-allowed characters from variables
# '-' are not allowed for dynamodb names
# '_' are not allowed for s3 bucket names
locals {
  s3_bucket_name = "${replace(var.state_name, "_", "-")}"
  dynamodb_table_name = "${replace(var.state_name, "-", "_")}"
}

provider "aws" {
  region = "${var.region}"
}

# Create an S3 bucket which we will use for storing the terraform state file
resource "aws_s3_bucket" "terraform-state-storage-s3" {
    bucket = "${local.s3_bucket_name}"
 
    versioning {
      enabled = true
    }
 
    lifecycle {
      prevent_destroy = true
    }
 
    tags {
      Name = "S3 Terraform Remote State Storage"
      Managed-By = "Terraform"
    }      
}

# Create a dynamodb table for locking the terraform state file
resource "aws_dynamodb_table" "dynamodb-terraform-state-lock" {
  name = "${local.dynamodb_table_name}"
  hash_key = "LockID"
  read_capacity = 20
  write_capacity = 20
 
  attribute {
    name = "LockID"
    type = "S"
  }
 
  tags {
    Name = "DynamoDB Terraform State Lock Table"
    Managed-By = "Terraform"
  }
}