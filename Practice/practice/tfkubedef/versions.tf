# Terraform Settings Block
terraform {
  required_version = ">= 1.0.0"
  
  # Terraform Providers Settings BLock
  required_providers {
    
    # Terraform AWS Provider Plug-in Block
    aws = {
      source = "hashicorp/aws"
      version = "~> 4.50"
    }

    # Terraform Kubernetes Provider Plug-in Block
    kubernetes = {
      source = "hashicorp/kubernetes"
      version = "~> 2.16"
    }    
  }

  # Adding Backend as S3 for Remote State Storage
  backend "s3" {
    bucket = "terraform-on-aws-eks-jys"
    key    = "dev/app1k8s/terraform.tfstate"
    region = "ap-northeast-2"
    dynamodb_table = "dev-app1k8s"  # For State Locking
  }
}