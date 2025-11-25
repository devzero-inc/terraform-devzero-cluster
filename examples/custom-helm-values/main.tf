# Example: Using raw YAML values for complete Helm customization

module "devzero_cluster" {
  source       = "../../modules/cluster"
  cluster_name = "custom-values-cluster"
}

# Using values_yaml for complete control
module "zxporter_custom" {
  source = "../../modules/zxporter"
  
  cluster_name  = module.devzero_cluster.cluster_name
  cluster_token = module.devzero_cluster.cluster_token
  
  # Override ALL values with custom YAML
  values_yaml = yamlencode({
    zxporter = {
      kubeContextName = module.devzero_cluster.cluster_name
      clusterToken    = module.devzero_cluster.cluster_token
      dakrUrl         = "https://dakr.devzero.io"
      k8sProvider     = "azure"
      
      # Advanced configuration
      metrics = {
        enabled = true
        interval = "30s"
      }
      
      resources = {
        limits = {
          cpu    = "1"
          memory = "1Gi"
        }
        requests = {
          cpu    = "100m"
          memory = "128Mi"
        }
      }
      
      nodeSelector = {
        "node-role.kubernetes.io/monitoring" = "true"
      }
      
      tolerations = [{
        key      = "monitoring"
        operator = "Equal"
        value    = "true"
        effect   = "NoSchedule"
      }]
    }
    
    monitoring = {
      prometheus = {
        enabled = true
        retention = "15d"
        storageSize = "50Gi"
      }
    }
  })
}

# Operator with mixed approach - YAML base + overrides
module "operator_custom" {
  source = "../../modules/operator"
  
  cluster_name  = module.devzero_cluster.cluster_name
  cluster_token = module.devzero_cluster.cluster_token
  
  # Base configuration via YAML
  values_yaml = file("${path.module}/operator-values.yaml")
  
  # Override specific values
  set_values = [
    {
      name  = "operator.clusterName"
      value = module.devzero_cluster.cluster_name
    }
  ]
  
  set_sensitive_values = [
    {
      name  = "operator.clusterToken"
      value = module.devzero_cluster.cluster_token
    }
  ]
}