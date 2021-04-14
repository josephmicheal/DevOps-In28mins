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

variable "users" {
  default = [
     "Joseph", "Kingston", "Leo"]
}


resource "aws_iam_user" "my_iam_users" {
  for_each = toset(var.names)
  name     = each.value
}