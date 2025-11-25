# Create the DevZero cluster
resource "devzero_cluster" "cluster" {
  name = var.cluster_name
}

# Deploy zxporter using the module
module "zxporter" {
  source             = "./modules/zxporter"
  cluster_name       = var.cluster_name
  cluster_token      = devzero_cluster.cluster.token
  endpoint           = var.endpoint
  cloud_provider     = var.cloud_provider
  enable_prometheus  = var.provision_prometheus
  set_values         = var.zxporter_extra_values
}

# Deploy operator using the module
module "operator" {
  source                      = "./modules/operator"
  cluster_name                = var.cluster_name
  cluster_token               = devzero_cluster.cluster.token
  endpoint                    = var.endpoint
  cloud_provider              = var.cloud_provider
  enable_scheduler            = var.enable_scheduler
  enable_live_migration_agent = var.enable_live_migration_agent
  runtime                     = var.runtime
  containerd_config_path      = var.containerd_config_path
  containerd_socket_path      = var.containerd_socket_path
  set_values                  = var.operator_extra_values
}
