provider "aws" {
    region = "eu-west-1"
}

resource "aws_instance" "example02" {
    ami                 = "ami-0ea3405d2d2522162"
    instance_type       = "t2.micro"

    tags = {
        Name = "terraform-example-02"
    }
}