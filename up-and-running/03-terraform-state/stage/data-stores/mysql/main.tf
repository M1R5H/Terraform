provider "aws" {
    region = "eu-west-1"
}

terraform {
    backend "s3" {

        bucket          = "terraform-state-m1r5h"
        key             = "stage/data-stores/mysql/terraform.tfstate"
        region          = "eu-west-1"

        dynamodb_table  = "terraform-locks-m1r5h"
        encrypt         = "true"
    }
}


resource "aws_db_instance" "example03" {

    identifier_prefix       = "terraform-m1r5h"
    engine                  = "mysql"
    allocated_storage       = 10
    instance_class          = "db.t2.micro"
    name                    = "m1r5h_database"
    username                = "admin"

    password                = var.db_password

}

variable "db_password" {
    type        = string
    description = "DB Password for MySQL"
}