provider "aws" {
     region = "ap-south-1"
}

module "ec2_instance_create" {
    source = "../modules/ec2_instance_create"
    ami_id = "ami-002f6e91abff6eb96"
    instance_type = "t2.micro"
}
