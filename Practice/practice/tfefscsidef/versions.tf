# Terraform Settings Block
terraform {
  required_version = ">= 1.0.0"
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 4.50"
     }
    helm = {
      source = "hashicorp/helm"
      #version = "2.8.1"
      version = "~> 2.8"
    }
    http = {
      source = "hashicorp/http"
      #version = "3.2.0"
      version = "~> 3.2"
    }
  }
  # Adding Backend as S3 for Remote State Storage
  backend "s3" {
    bucket = "terraform-on-aws-eks-jys"
    key    = "dev/efs-csi/terraform.tfstate"
    region = "ap-northeast-2"

    # For State Locking
    dynamodb_table = "dev-efs-csi"
  }     
}
# Terraform AWS Provider Block
provider "aws" { region = var.aws_region }

# Terraform HTTP Provider Block
provider "http" { /* Configuration options */ }