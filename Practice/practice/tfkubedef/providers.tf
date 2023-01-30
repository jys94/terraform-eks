# Terraform AWS Provider Block
provider "aws" { region = "ap-northeast-2" }
# Terraform EKS Cluster Attributes Reference Block
data "aws_eks_cluster" "cluster" { name = data.terraform_remote_state.eks.outputs.cluster_id }
data "aws_eks_cluster_auth" "cluster" { name = data.terraform_remote_state.eks.outputs.cluster_id }

# Terraform Kubernetes Provider Block (Communicatable with Kube-API)
provider "kubernetes" {
  host = data.terraform_remote_state.eks.outputs.cluster_endpoint 
  cluster_ca_certificate = base64decode(data.terraform_remote_state.eks.outputs.cluster_certificate_authority_data)
  token = data.aws_eks_cluster_auth.cluster.token
}