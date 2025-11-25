# Example: Deploy only the operator component
module "devzero_cluster" {
  source = ".."
  
  cluster_name      = "workload-cluster"
  cloud_provider    = "gcp"
  
  # Enable only operator
  enable_zxporter = false
  enable_operator = true
  
  # Operator configuration
  enable_scheduler            = true
  enable_live_migration_agent = true
  runtime                     = "k3s"
  
  # Custom operator configuration
  operator_extra_values = [
    {
      name  = "operator.logLevel"
      value = "debug"
    },
    {
      name  = "scheduler.replicas"
      value = "2"
    }
  ]
}