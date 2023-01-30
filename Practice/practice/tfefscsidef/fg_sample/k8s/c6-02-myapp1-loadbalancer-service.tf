# Resource: Kubernetes Service Manifest (Type: Load Balancer - Classic)
resource "kubernetes_service_v1" "lb_service" {
  metadata {
    name = "myapp1-clb-service"
    namespace = "fp-ns-app1"
    annotations = {
      "external-dns.alpha.kubernetes.io/hostname" = "clb.eksinfra.com"
    }
  }
  spec {
    selector = {
      app = kubernetes_deployment_v1.myapp1.spec[0].selector[0].match_labels.app
    }
    port {
      port        = 80
      target_port = 80
    }
    type = "LoadBalancer"
  }
}