provider aws {
    region = "eu-west-1"
}

terraform {
    backend "s3" {

        bucket          = "terraform-state-m1r5h"
        key             = "global/s3/terraform.tfstate"
        region          = "eu-west-1"

        dynamodb_table  = "terraform-locks-m1r5h"
        encrypt         = "true"
    }
}

resource "aws_s3_bucket" "terraform_state" {

    bucket = "terraform-state-m1r5h"

    # lifecycle {
    #     prevent_before_destroy = true
    # }

    versioning {
        enabled = true
    }

    server_side_encryption_configuration {
        rule {
            apply_server_side_encryption_by_default {
                sse_algorithm = "AES256"
            }
        }
    }
}


resource "aws_dynamodb_table" "terraform_locks" {
    name            = "terraform-locks-m1r5h"
    billing_mode    = "PAY_PER_REQUEST"
    hash_key        = "LockID"

    attribute {
        name = "LockID"
        type = "S"
    }
}

output "s3_bucket_arn" {
  value       = aws_s3_bucket.terraform_state.arn
  description = "The ARN of the S3 bucket"
}

output "dynamodb_table_name" {
  value       = aws_dynamodb_table.terraform_locks.name
  description = "The name of the DynamoDB table"
}