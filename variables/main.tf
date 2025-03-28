provider "aws" {
  region = "ap-south-1"
}

variable "instance_type" {
  description = "variable for ec2_instance type"
  type        = string
  default     = "t2.micro"
}

resource "aws_instance" "my-instance" {
  ami                     = "ami-0e35ddab05955cf57"
  instance_type           = var.instance_type
}

output "public_ip" {
  value = resource.aws_instance.my-instance.public_ip
}
