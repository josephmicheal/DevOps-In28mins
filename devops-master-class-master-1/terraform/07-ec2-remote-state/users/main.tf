terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }

  backend "s3" {
    bucket="dev-apps-backend-state-joseph801"
    key="804_App_Proj_Env"
    region="us-east-1"
    dynamodb_table="dev_apps_locks"
    encrypt=true
  }
}
 
# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
  # VERSION IS NOT NEEDED HERE
}