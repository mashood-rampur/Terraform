output "public_ip" {
  value = resource.aws_instance.my-instance.public_ip
}
