resource "aws_instance" "my-instance" {
  ami                     = "ami-0e35ddab05955cf57"
  instance_type           = var.instance_type
}

output "public_ip" {
  value = resource.aws_instance.my-instance.public_ip
}
