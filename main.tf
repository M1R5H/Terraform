provider "aws" {
    region = "us-east-1"
}


resource "aws_vpc" "main" {
    cidr_block = "10.1.0.0/16"

    tags = {
        name = "TerraformVPC"
    }
}

##ROUTE TABLE WITH IGW NEEDED HERE AND ASSIGNED TO VPC

resource "aws_subnet" "public1" {
    vpc_id = "${aws_vpc.main.id}"
    cidr_block = "10.1.0.0/24"

    tags = {
        name = "TerraformPublic1"
    }
}

resource "aws_subnet" "private1" {
    vpc_id = "${aws_vpc.main.id}"
    cidr_block = "10.1.1.0/24"

    tags = {
        name = "TerraformPrivate1"
    }
}

resource "aws_instance" "example" {
    ami           = "ami-04947a9263d1b2ddd"
    instance_type = "t2.micro"
    associate_public_ip_address = "true"
    

    subnet_id = "${aws_subnet.public1.id}"
    vpc_security_group_ids = ["${aws_security_group.http_ssh.id}"]

    tags = {
        name = "terraformed-example"
    }
}

resource "aws_security_group" "http_ssh" {
    name = "terraform-example-instance" 
    vpc_id="${aws_vpc.main.id}"
    
     ingress {
        from_port   = "${var.server_port}"
        to_port     = "${var.server_port}"
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

variable "server_port" {
  description = "The port the server will use for HTTP requests"
  type        = "string"
  default     = 80
}


output "vpc_id" {
  value       = "${aws_vpc.main.id}"
  description = "VPC ID"
}

output "publicsubnet" {
  value       = "${aws_subnet.public1.id}"
  description = "VPC ID"
}

output "public_ip" {
  value = "${aws_instance.example.public_ip}"
  description = "IP Address of the server"
}