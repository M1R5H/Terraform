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


# resource "aws_instance" "example" {
#   ami           = "ami-0c55b159cbfafe1f0"
#   instance_type = terraform.workspace == "default" ? "t2.medium" : "t2.micro"
# }


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

