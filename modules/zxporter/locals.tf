locals {
  # Default values for backward compatibility when using convenience variables
  default_values = var.cluster_name != null || var.cluster_token != null ? [
    {
      name  = "zxporter.kubeContextName"
      value = var.cluster_name
    },
    {
      name  = "zxporter.k8sProvider"
      value = var.cloud_provider
    },
    {
      name  = "monitoring.prometheus.enabled"
      value = tostring(var.enable_prometheus)
    },
    {
      name  = "zxporter.dakrUrl"
      value = var.endpoint
    }
  ] : []

  default_sensitive_values = var.cluster_token != null ? [
    {
      name  = "zxporter.clusterToken"
      value = var.cluster_token
    }
  ] : []
}