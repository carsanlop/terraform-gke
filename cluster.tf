provider "google" {
   project = "${var.project}"
   region  = "${var.region}"
}

data "google_client_config" "current" {}

resource "google_container_cluster" "primary" {
  name = "${var.cluster_name}"
  location = "${var.cluster_location}"
  remove_default_node_pool = false
  initial_node_count = "${var.pool_min_nodes}"
  node_config {
    machine_type = "${var.pool_machine_type}"
    preemptible = true
    oauth_scopes = [
      "https://www.googleapis.com/auth/compute",
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring"
    ]
  }
  master_auth {
    username = ""
    password = ""
    client_certificate_config {
      issue_client_certificate = false
    }
  }
}

resource "google_compute_address" "cluster_ip" {
  name = "${var.cluster_name}-ingress"
  address_type = "EXTERNAL"
}

output "cluster_address" {
  description = "IP for accessing the ingress resource"
  value = "${google_compute_address.cluster_ip.address}"
}