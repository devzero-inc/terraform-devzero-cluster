# Use sub-modules for better modularity and flexibility
module "cluster" {
  source       = "./modules/cluster"
  cluster_name = var.cluster_name
}

module "zxporter" {
  source             = "./modules/zxporter"
  cluster_name       = var.cluster_name
  cluster_token      = module.cluster.cluster_token
  endpoint           = var.endpoint
  cloud_provider     = var.cloud_provider
  enable_prometheus  = var.provision_prometheus
  set_values         = var.zxporter_extra_values
}

module "operator" {
  source                      = "./modules/operator"
  cluster_name                = var.cluster_name
  cluster_token               = module.cluster.cluster_token
  endpoint                    = var.endpoint
  cloud_provider              = var.cloud_provider
  enable_scheduler            = var.enable_scheduler
  enable_live_migration_agent = var.enable_live_migration_agent
  runtime                     = var.runtime
  containerd_config_path      = var.containerd_config_path
  containerd_socket_path      = var.containerd_socket_path
  set_values                  = var.operator_extra_values
}
