provider "kubernetes" {
  load_config_file = false
  host = "${google_container_cluster.primary.endpoint}"
  cluster_ca_certificate = "${base64decode(google_container_cluster.primary.master_auth.0.cluster_ca_certificate)}"
  token = "${data.google_client_config.current.access_token}"
}

resource "kubernetes_service_account" "helm_account" {
  depends_on = [
    "google_container_cluster.primary"
  ]
  metadata {
    name = "${var.helm_account_name}"
    namespace = "kube-system"
  }
}
resource "kubernetes_cluster_role_binding" "helm_role_binding" {
  metadata {
    name = "${kubernetes_service_account.helm_account.metadata.0.name}"
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "cluster-admin"
  }
  subject {
    api_group = ""
    kind = "ServiceAccount"
    name      = "${kubernetes_service_account.helm_account.metadata.0.name}"
    namespace = "kube-system"
  }
  provisioner "local-exec" {
    command = "sleep 15"
  }
  depends_on = [
    "kubernetes_service_account.helm_account"
  ]
}