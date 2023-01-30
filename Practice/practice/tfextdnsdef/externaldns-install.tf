# Resource: Helm Release 
resource "helm_release" "external_dns" {
  depends_on = [aws_iam_role.externaldns_iam_role]            
  name       = "external-dns"

  repository = "https://kubernetes-sigs.github.io/external-dns/"
  chart      = "external-dns"
  namespace = "default"
 
  set {
    name = "image.repository"
    value = "k8s.gcr.io/external-dns/external-dns" 
  }

  set {
    name  = "serviceAccount.create"
    value = "true"
  }

  set {
    name  = "serviceAccount.name"
    value = "external-dns"
  }

  set {
    name  = "serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
    value = "${aws_iam_role.externaldns_iam_role.arn}"
  }

  set {
    # Default is aws (https://github.com/kubernetes-sigs/external-dns/tree/master/charts/external-dns)
    name  = "provider"
    value = "aws"
  }

  set {
    name  = "policy"
    ### (https://github.com/kubernetes-sigs/external-dns/tree/master/charts/external-dns)
    ## Default is "upsert-only", ##
    #> which means DNS records will not get deleted even equivalent Ingress resources are deleted
    ## "sync" will ensure that when ingress resource is deleted, ##
    #> equivalent DNS record in Route53 will get deleted
    value = "sync"
  }
}