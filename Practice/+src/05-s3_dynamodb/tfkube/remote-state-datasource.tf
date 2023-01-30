# Terraform Remote State Datasource
/*
data "terraform_remote_state" "eks" {
  backend = "local"
  
  config = {
    path = "../tfconfdef/terraform.tfstate"
   }
}
*/


# Terraform Remote State Datasource - Remote Backend AWS S3
data "terraform_remote_state" "eks" {
  backend = "s3"
  
  config = {
    bucket = "terraform-on-aws-eks-jys"
    key    = "dev/eks-cluster/terraform.tfstate"
    region = "ap-northeast-2"
  }
}