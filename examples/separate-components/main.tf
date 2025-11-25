# Example: Deploy components separately with full control

# Step 1: Create the cluster
resource "devzero_cluster" "cluster" {
  name = "my-cluster"
}

# Step 2: Deploy zxporter with custom configuration
module "zxporter" {
  source = "../../modules/zxporter"
  
  # Basic configuration
  cluster_name  = devzero_cluster.cluster.name
  cluster_token = devzero_cluster.cluster.token
  
  # Custom Helm values
  chart_version = "0.0.23"  # Override default version
  namespace     = "custom-monitoring"
  
  # Full control over Helm values
  set_values = [
    {
      name  = "resources.limits.memory"
      value = "512Mi"
    },
    {
      name  = "resources.limits.cpu"
      value = "500m"
    },
    {
      name  = "monitoring.prometheus.retention"
      value = "30d"
    }
  ]
}

# Step 3: Deploy operator with custom configuration
module "operator" {
  source = "../../modules/operator"
  
  # Basic configuration
  cluster_name  = devzero_cluster.cluster.name
  cluster_token = devzero_cluster.cluster.token
  
  # Custom settings
  enable_scheduler            = true
  enable_live_migration_agent = true
  runtime                     = "k3s"
  
  # Additional Helm values
  set_values = [
    {
      name  = "operator.logLevel"
      value = "debug"
    },
    {
      name  = "agent.resources.limits.memory"
      value = "1Gi"
    }
  ]
}