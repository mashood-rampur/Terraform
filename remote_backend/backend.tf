terraform {
  backend "s3" {
    bucket         = "mashood-demo-s3-abc" # change this
    key            = "mashood/terraform.tfstate"
    region         = "ap-south-1"
    encrypt        = true
    dynamodb_table = "terraform-lock"
  }
}
