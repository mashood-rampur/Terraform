provider "aws" {
  alias = "first"
  region = "ap-south-1"
}

provider "aws" {
  alias = "second"
  region = "us-east-1"
}

resource "aws_instance" "example" {
  ami = "ami-076c6dbba59aa92e6"
  instance_type = "t2.micro"
  provider = aws.first
}

resource "aws_instance" "example2" {
  ami = "ami-084568db4383264d4"
  instance_type = "t2.micro"
  provider = aws.second
}
