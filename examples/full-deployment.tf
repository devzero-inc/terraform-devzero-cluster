# Example: Full deployment with both components (default behavior)
module "devzero_cluster" {
  source = ".."
  
  cluster_name   = "full-cluster"
  cloud_provider = "azure"
  
  # Both components enabled by default
  # enable_zxporter = true  # default
  # enable_operator = true  # default
  
  # Configure all features
  enable_scheduler            = true
  enable_live_migration_agent = false
  provision_prometheus        = true
  runtime                     = "containerd"
  
  # Custom configurations for both components
  zxporter_extra_values = [
    {
      name  = "zxporter.logLevel"
      value = "info"
    }
  ]
  
  operator_extra_values = [
    {
      name  = "operator.resources.limits.memory"
      value = "1Gi"
    }
  ]
}