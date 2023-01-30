# Terraform Settings Block
terraform {
  required_version = ">= 1.0.0"
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 4.50"
     }
    kubernetes = {
      source = "hashicorp/kubernetes"
      version = "~> 2.16"
    }      
  }
}
# Terraform AWS Provider Block
provider "aws" {
  region = var.aws_region
}