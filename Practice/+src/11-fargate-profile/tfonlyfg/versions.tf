# Terraform Block
terraform {
  # which means any version equal & above 0.14 like 0.15, 0.16 etc and < 1.xx
  required_version = ">= 1.0.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.50"
    }
  }

  # Adding Backend as S3 for Remote State Storage
  backend "s3" {
    bucket = "terraform-on-aws-eks-jys"
    key    = "dev/eks-cluster/terraform.tfstate"
    region = "ap-northeast-2"
    # For State Locking
    dynamodb_table = "dev-eks-cluster"
  }
}

# Provider Block
provider "aws" {
  region  = var.aws_region
}