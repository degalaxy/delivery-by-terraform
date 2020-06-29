variable "secret_id" {}
variable "secret_key" {}
variable "region" {}
variable "availability_zones" {}
variable "wecube_release_version" {}
variable "initial_password" {}
variable "default_mysql_port" {}

variable "artifact_repo_secret_id" {}
variable "artifact_repo_secret_key" {}
variable "artifact_repo_region" {}
variable "artifact_repo_bucket" {}


locals {
  cluster_mode                = length(var.availability_zones) > 1
  primary_availability_zone   = var.availability_zones[0]
  secondary_availability_zone = local.cluster_mode ? var.availability_zones[1] : ""
}
