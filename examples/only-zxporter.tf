# Example: Deploy only zxporter (monitoring/exporter component)
module "devzero_cluster" {
  source = ".."
  
  cluster_name      = "monitoring-cluster"
  cloud_provider    = "aws"
  
  # Enable only zxporter
  enable_zxporter = true
  enable_operator = false
  
  # Configure prometheus monitoring
  provision_prometheus = true
  
  # Custom zxporter configuration
  zxporter_extra_values = [
    {
      name  = "resources.limits.memory"
      value = "512Mi"
    },
    {
      name  = "monitoring.prometheus.retention"
      value = "30d"
    }
  ]
}