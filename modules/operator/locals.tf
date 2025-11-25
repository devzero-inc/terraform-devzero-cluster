locals {
  containerd_config_path = {
    containerd = "/etc/containerd/config.toml"
    rke2       = "/var/lib/rancher/rke2/agent/etc/containerd/config.toml"
    k3s        = "/var/lib/rancher/k3s/agent/etc/containerd/config.toml"
  }
  
  containerd_socket_path = {
    containerd = "/run/containerd/containerd.sock"
    rke2       = "/var/lib/rancher/rke2/agent/containerd/containerd.sock"
    k3s        = "/var/lib/rancher/k3s/agent/containerd/containerd.sock"
  }

  # Default values for backward compatibility when using convenience variables
  default_values = var.cluster_name != null || var.cluster_token != null ? [
    {
      name  = "cloud"
      value = var.cloud_provider
    },
    {
      name  = "operator.clusterName"
      value = var.cluster_name
    },
    {
      name  = "operator.noCloudCreds"
      value = tostring(var.cloud_provider == "")
    },
    {
      name  = "operator.endpoint"
      value = var.endpoint
    },
    {
      name  = "scheduler.enabled"
      value = tostring(var.enable_scheduler)
    },
    {
      name  = "scheduler.controlPlaneAddress"
      value = var.endpoint
    },
    {
      name  = "agent.enabled"
      value = tostring(var.enable_live_migration_agent)
    },
    {
      name  = "agent.runtime"
      value = var.runtime
    },
    {
      name  = "agent.containerdConfigPath"
      value = coalesce(var.containerd_config_path, lookup(local.containerd_config_path, var.runtime, "/etc/containerd/config.toml"))
    },
    {
      name  = "agent.containerdSock"
      value = coalesce(var.containerd_socket_path, lookup(local.containerd_socket_path, var.runtime, "/run/containerd/containerd.sock"))
    }
  ] : []

  default_sensitive_values = var.cluster_token != null ? [
    {
      name  = "operator.clusterToken"
      value = var.cluster_token
    },
    {
      name  = "scheduler.controlPlaneToken"
      value = var.cluster_token
    }
  ] : []
}