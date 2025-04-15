provider "aws" {
    region = "ap-south-1"
}

variable "role_id" {
  description = "variable for role_id"
}

variable "secret_id" {
  description = "variable for secret_id"
}

provider "vault" {
  address = "http://13.232.96.162:8200/"
  skip_child_token = true

  auth_login {
    path = "auth/approle/login"

    parameters = {
      role_id   = var.role_id
      secret_id = var.secret_id
    }
  }
}

data "vault_kv_secret_v2" "example" {
  mount = "kv"
  name  = "secrets"
}

resource "aws_instance" "example" {
  ami = "ami-0e35ddab05955cf57"
  instance_type = "t2.micro"

 tags = {
    Name = "test"
    secret = data.vault_kv_secret_v2.example.data["secret"]
    }
}
