provider "aws" {
  region = "ap-south-1"
}

variable "enable_ssh" {
  description = "variable for ssh"
  type        = string
  default     = "false"
}

resource "aws_security_group" "example" {
  name = "example-sg"
  description = "Example security group"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.enable_ssh ? ["0.0.0.0/0"] : []
  }
}
