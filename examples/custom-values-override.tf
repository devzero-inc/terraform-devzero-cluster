# Example: Using extra_values to fully customize Helm chart values
module "devzero_cluster" {
  source = ".."
  
  cluster_name = "custom-cluster"
  
  # Deploy both components with extensive customization
  enable_zxporter = true
  enable_operator = true
  
  # Override any Helm value for zxporter
  zxporter_extra_values = [
    {
      name  = "zxporter.image.tag"
      value = "0.0.23"  # Override default chart version
    },
    {
      name  = "zxporter.nodeSelector.workload-type"
      value = "monitoring"
    },
    {
      name  = "monitoring.prometheus.serviceMonitor.labels.team"
      value = "platform"
    },
    {
      name  = "tolerations[0].key"
      value = "monitoring"
    },
    {
      name  = "tolerations[0].operator"
      value = "Equal"
    },
    {
      name  = "tolerations[0].value"
      value = "true"
    },
    {
      name  = "tolerations[0].effect"
      value = "NoSchedule"
    }
  ]
  
  # Override any Helm value for operator
  operator_extra_values = [
    {
      name  = "operator.image.tag"
      value = "0.1.10"  # Override default chart version
    },
    {
      name  = "scheduler.resources.requests.cpu"
      value = "100m"
    },
    {
      name  = "scheduler.resources.requests.memory"
      value = "128Mi"
    },
    {
      name  = "agent.daemonset.updateStrategy.type"
      value = "RollingUpdate"
    },
    {
      name  = "agent.daemonset.updateStrategy.rollingUpdate.maxUnavailable"
      value = "1"
    }
  ]
}