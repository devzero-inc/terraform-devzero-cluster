# Example: Multiple zxporter instances with different configurations

module "devzero_cluster" {
  source       = "../../modules/cluster"
  cluster_name = "multi-exporter-cluster"
}

# Primary exporter with Prometheus
module "zxporter_primary" {
  source = "../../modules/zxporter"
  
  release_name      = "zxporter-primary"
  cluster_name      = module.devzero_cluster.cluster_name
  cluster_token     = module.devzero_cluster.cluster_token
  enable_prometheus = true
  
  set_values = [
    {
      name  = "monitoring.prometheus.serviceMonitor.labels.team"
      value = "platform"
    }
  ]
}

# Secondary exporter without Prometheus for different namespace
module "zxporter_secondary" {
  source = "../../modules/zxporter"
  
  release_name      = "zxporter-apps"
  namespace         = "devzero-apps-monitoring"
  cluster_name      = module.devzero_cluster.cluster_name
  cluster_token     = module.devzero_cluster.cluster_token
  enable_prometheus = false
  
  # Different endpoint for testing/staging
  endpoint = "https://staging-dakr.devzero.io"
  
  set_values = [
    {
      name  = "zxporter.logLevel"
      value = "info"
    }
  ]
}

# Single operator instance
module "operator" {
  source = "../../modules/operator"
  
  cluster_name  = module.devzero_cluster.cluster_name
  cluster_token = module.devzero_cluster.cluster_token
}