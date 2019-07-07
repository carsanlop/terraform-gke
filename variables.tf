variable "project" {
  type = "string"
  description = "The default project to manage resources in."
}

variable "region" {
  type = "string"
  description = "The default region to manage resources in."
}

variable "cluster_name" {
  type = "string"
  description = "The name for the cluster. It will also be used as base name for associated resources."
}

variable "cluster_location" {
  type        = "string"
  description = "The location (region or zone) in which the cluster master will be created, as well as the default node location. If you specify a zone (such as us-central1-a), the cluster will be a zonal cluster with a single cluster master. If you specify a region (such as us-west1), the cluster will be a regional cluster with multiple masters spread across zones in the region, and with default node locations in those zones as well."
}

variable "pool_machine_type" {
  type        = "string"
  description = "Machine type to use for the general-purpose node pool."
  default     = "n1-standard-1"
}

variable "pool_min_nodes" {
  type        = "string"
  description = "The minimum number of nodes in the general-purpose node pool."
  default     = "1"
}

variable "pool_max_nodes" {
  type        = "string"
  description = "The maximum number of nodes in the general-purpose node pool."
  default     = "3"
}

variable "helm_version" {
  description = "A valid Tiller version. It must correspond to the tiller image tag."
  default     = "v2.14.1"
}

variable "helm_account_name" {
  default = "tiller"
}