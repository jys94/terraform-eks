locals {
  tables = {
    eks_read     = { "dev-${local.backends[0]}" = "Read"  }
    eks_write    = { "dev-${local.backends[0]}" = "Write" }
    app_read     = { "dev-${local.backends[1]}" = "Read"  }
    app_write    = { "dev-${local.backends[1]}" = "Write" }
    lbc_read     = { "dev-${local.backends[2]}" = "Read"  }
    lbc_write    = { "dev-${local.backends[2]}" = "Write" }
    ing_read     = { "dev-${local.backends[3]}" = "Read"  }
    ing_write    = { "dev-${local.backends[3]}" = "Write" }
    dns_read     = { "dev-${local.backends[4]}" = "Read"  }
    dns_write    = { "dev-${local.backends[4]}" = "Write" }
    efscsi_read  = { "dev-${local.backends[5]}" = "Read"  }
    efscsi_write = { "dev-${local.backends[5]}" = "Write" }
    scaler_read  = { "dev-${local.backends[6]}" = "Read"  }
    scaler_write = { "dev-${local.backends[6]}" = "Write" }
    cwagent_read  = { "dev-${local.backends[7]}" = "Read"  }
    cwagent_write = { "dev-${local.backends[7]}" = "Write" }
  }
  backends = [ "eks-cluster", "app1k8s", "aws-lbc", "ingress", "aws-externaldns", "efs-csi", "eks-autoscaler", "eks-cloudwatch-agent" ]
}