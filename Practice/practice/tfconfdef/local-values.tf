# Define Local Values in Terraform

locals {
  owners = var.business_divsion
  environment = var.environment
  name = "${var.business_divsion}-${var.environment}"
  #name = "${local.owners}-${local.environment}"

  common_tags = {
    owners = local.owners
    environment = local.environment
  }

  eks_cluster_name = "${local.name}-${var.cluster_name}"

  node_groups = {
    web        = "nodegroup-web",
    was        = "nodegroup-was",
    cicd       = "nodegroup-cicd",
    monitoring = "nodegroup-monitoring"
  }

  ngs = { for ng in var.provision-ngs: ng => local.node_groups[ng]}
}