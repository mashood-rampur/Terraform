provider "aws" {
  region = "ap-south-1"
}

variable "create_instance" {
  description = "variable for instance"
  type        = string
  default     = "0"
}

resource "aws_instance" "example" {
  count = var.create_instance ? 1 : 0

  ami           = "ami-002f6e91abff6eb96"
  instance_type = "t2.micro"
}
