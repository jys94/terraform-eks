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

    http = {
      source = "hashicorp/http"
      version = "~> 3.2"
    }

    kubectl = {
      source = "gavinbunney/kubectl"
      version = "1.14.0"
    }     
  }

  # Adding Backend as S3 for Remote State Storage
  backend "s3" {
    bucket = "terraform-on-aws-eks-jys"
    key    = "dev/eks-cloudwatch-agent/terraform.tfstate"
    region = "ap-northeast-2"

    # For State Locking
    dynamodb_table = "dev-eks-cloudwatch-agent"    
  }
}