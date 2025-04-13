provider "aws" {
  region = "ap-south-1"
}

variable "ami" {
  description = "variable for the AMI of EC2"
}

variable "instance_type" {
  description = "variable for instance type"
}

resource "aws_instance" "example" {
  ami = var.ami
  instance_type = var.instance_type
}
