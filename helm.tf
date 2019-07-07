provider "helm" {
  service_account = "${kubernetes_service_account.helm_account.metadata.0.name}"
  tiller_image = "gcr.io/kubernetes-helm/tiller:${var.helm_version}"
  install_tiller  = true
  kubernetes {
    host  = "${google_container_cluster.primary.endpoint}"
    token = "${data.google_client_config.current.access_token}"
    client_certificate = "${base64decode(google_container_cluster.primary.master_auth.0.client_certificate)}"
    client_key = "${base64decode(google_container_cluster.primary.master_auth.0.client_key)}"
    cluster_ca_certificate = "${base64decode(google_container_cluster.primary.master_auth.0.cluster_ca_certificate)}"
  }
}

resource "helm_release" "ingress" {
  chart = "stable/nginx-ingress"
  name = "nginx-ingress"
  namespace = "kube-system"
  set {
    name  = "controller.service.loadBalancerIP"
    value = "${google_compute_address.cluster_ip.address}"
  }
  depends_on = [
    "kubernetes_cluster_role_binding.helm_role_binding"
  ]
}