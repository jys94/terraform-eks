# Terraform Settings Block
terraform {
  required_version = ">= 1.0.0"

  required_providers {
    aws = { # Using - Cluster Autoscaler & Metrics Server
      source = "hashicorp/aws"
      version = "~> 4.50"
    }
    helm = { # Using - Cluster Autoscaler & Metrics Server
      source = "hashicorp/helm"
      #version = "2.8.1"
      version = "~> 2.8"
    }

    http = { # Using - Cluster Autoscaler
      source = "hashicorp/http"
      #version = "3.2.0"
      version = "~> 3.2"
    }
    kubernetes = { # Using - Cluster Autoscaler
      source = "hashicorp/kubernetes"
      version = "~> 2.16"
    }

    null = { # Using - VPA
      source = "hashicorp/null"
      version = "~> 3.2"
    }
  }
  
  # Adding Backend as S3 for Remote State Storage
  backend "s3" {
    bucket = "terraform-on-aws-eks-jys"
    key    = "dev/eks-autoscaler/terraform.tfstate"
    region = "ap-northeast-2"

    # For State Locking
    dynamodb_table = "dev-eks-autoscaler"
  }     
}