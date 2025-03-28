variable "instance_type" {
  description = "variable for ec2_instance type"
  type        = string
  default     = "t2.micro"
}

variable "ami_id" {
  description = "variable for ec2_ami_id"
  type        = string
  default     = "ami-0e35ddab05955cf57"
}
