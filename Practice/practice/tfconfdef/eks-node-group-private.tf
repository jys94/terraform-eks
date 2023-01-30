# Create AWS EKS Node Group Templates
resource "aws_launch_template" "ng_launch_template" {
  for_each = local.ngs
  name = each.value
  ebs_optimized = true
  key_name = "Instance-Access-Key"
  user_data = each.key == "cicd" ? data.cloudinit_config.cloudinit-jenkins.rendered : null
  vpc_security_group_ids = [aws_security_group.ng-remote-access.id, data.aws_security_group.cluster-sg.id]

  tag_specifications {
    resource_type = "instance"
    
    tags = {
      Name = each.value
    }
  }
}

# template version reference to nodegroup's launch_template
data "aws_launch_template" "launch_template_ref" {
  for_each = local.ngs
  name = each.value

  depends_on = [
    aws_launch_template.ng_launch_template
  ]
}

# Create AWS EKS Node Group - Private
resource "aws_eks_node_group" "eks_ng_private" {
  for_each = local.ngs
  cluster_name    = aws_eks_cluster.eks_cluster.name
  node_group_name = each.value
  node_role_arn   = aws_iam_role.eks_nodegroup_role.arn
  subnet_ids      = module.vpc.private_subnets
  version         = var.cluster_version #(Optional: Defaults to EKS Cluster Kubernetes version)
  
  ami_type = "AL2_x86_64"  
  capacity_type = each.key == "cicd" ? "SPOT" : "ON_DEMAND"
  instance_types = ["t3.large"]

  scaling_config {
    desired_size = 2
    min_size     = 2
    max_size     = 4
  }

  # Desired max percentage of unavailable worker nodes during node group update.
  update_config {
    max_unavailable = 1    
    #max_unavailable_percentage = 50    # ANY ONE TO USE
  }

  launch_template {
    name = each.value
    version = data.aws_launch_template.launch_template_ref[each.key].default_version
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
  # Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.
  depends_on = [
    aws_iam_role_policy_attachment.eks-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.eks-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.eks-AmazonEC2ContainerRegistryReadOnly,
  ]

  tags = {
    Name = each.value
    
    # Cluster Autoscaler Tags
    "k8s.io/cluster-autoscaler/${local.eks_cluster_name}" = "owned"
    "k8s.io/cluster-autoscaler/enabled" = "TRUE"	    
  }
}