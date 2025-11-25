# Example: Using raw YAML values for complete Helm customization

resource "devzero_cluster" "cluster" {
  name = "custom-values-cluster"
}

# Using values_yaml for complete control
module "zxporter_custom" {
  source = "../../modules/zxporter"
  
  cluster_name  = devzero_cluster.cluster.name
  cluster_token = devzero_cluster.cluster.token
  
  # Override ALL values with custom YAML
  values_yaml = yamlencode({
    zxporter = {
      kubeContextName = devzero_cluster.cluster.name
      clusterToken    = devzero_cluster.cluster.token
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
  
  cluster_name  = devzero_cluster.cluster.name
  cluster_token = devzero_cluster.cluster.token
  
  # Base configuration via YAML
  values_yaml = file("${path.module}/operator-values.yaml")
  
  # Override specific values
  set_values = [
    {
      name  = "operator.clusterName"
      value = devzero_cluster.cluster.name
    }
  ]
  
  set_sensitive_values = [
    {
      name  = "operator.clusterToken"
      value = devzero_cluster.cluster.token
    }
  ]
}