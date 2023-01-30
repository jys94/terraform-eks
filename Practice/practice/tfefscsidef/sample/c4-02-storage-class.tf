# Resource: Kubernetes Storage Class
resource "kubernetes_storage_class_v1" "efs_sc" {  
  metadata {
    name = "efs-sc"
  }
  storage_provisioner = "efs.csi.aws.com"

  # Parameters: https://github.com/kubernetes-sigs/aws-efs-csi-driver/blob/master/examples/kubernetes/dynamic_provisioning/README.md
  parameters = {
    provisioningMode = "efs-ap" # The type of volume to be provisioned by efs. Currently, only access point based provisioning is supported efs-ap.
    fileSystemId =  aws_efs_file_system.efs_file_system.id # The file system under which Access Point is created.
    directoryPerms = "700" # optional: Directory Permissions of the root directory by Access Point.
    gidRangeStart = "1000" # optional
    gidRangeEnd = "2000" # optional
    basePath = "/dynamic_provisioning" # optional
  }
}