provider "aws" {
  region = "ap-south-1"
}

resource "aws_instance" "example" {
  instance_type = "t2.micro"
  ami = "ami-053b0d53c279acc90" # change this
}

resource "aws_s3_bucket" "s3_bucket" {
  bucket = "mashood-demo-s3-abc" # change this
}

resource "aws_dynamodb_table" "terraform_lock" {
  name           = "terraform-lock"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}
