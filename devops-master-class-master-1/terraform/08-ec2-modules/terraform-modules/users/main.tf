terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}
 
provider "aws" {
  region = "us-east-1"
}

variable "environment" {
  default = "default"
}

locals {
  iam_user_prefix = "my_iam_user_804"
}

resource "aws_iam_user" "my_iam_user" {
  name = "${local.iam_user_prefix}_${var.environment}"
}