terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
  # VERSION IS NOT NEEDED HERE
}


variable "my_iam_users_prefex" {
  type    = string # any, number, bool, list, map, set, object, tuple
  #default = "my_iam_user"
}

resource "aws_iam_user" "my_iam_users" {
  count = 3
  name  = "${var.my_iam_users_prefex}_${count.index}"
}