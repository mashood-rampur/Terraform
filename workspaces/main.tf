provider "aws" {
    region = "ap-south-1" 
}

variable "ami" {
  description = "variable for AMI of EC2"
}

variable "instance_type" {
  description = "variable for instance type"
  type = map(string)
  
  default = {
    "dev" = "t2.micro"
    "stage" = "t2.medium"
    "prod" = "t2.small"
  }
}

module "EC2_instance" {
  source = "./modules/ec2_instance"
  ami = var.ami
  instance_type = lookup(var.instance_type, terraform.workspace, "t2.micro")
}
