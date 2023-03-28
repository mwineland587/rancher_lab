# Provider bootstrap config
provider "rancher2" {
  alias = "bootstrap"
  api_url   = "https://${aws_elb.lb.dns_name}"
  bootstrap = true
  insecure = true
}

# Create a new rancher2_bootstrap
resource "rancher2_bootstrap" "admin" {
  depends_on = [null_resource.ansible_upstream]
  provider = rancher2.bootstrap
  initial_password = local.bootstrap_password
  password = local.rancher_password
  telemetry = false
}

# Provider config for admin
provider "rancher2" {
  alias = "admin"

  api_url = rancher2_bootstrap.admin.url
  token_key = rancher2_bootstrap.admin.token
  insecure = true
}

# Create a new rancher v2 RKE2 custom Cluster v2
resource "rancher2_cluster_v2" "downstream1" {
  depends_on = [null_resource.ansible_upstream]
  provider = rancher2.admin
  name = "downstream1"
  kubernetes_version = "v1.23.16+rke2r1"
  enable_network_policy = false
  default_cluster_role_for_project_members = "user"
}
