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
    kubectl = {
      source = "gavinbunney/kubectl"
      version = "1.14.0"
    }     
  }
}