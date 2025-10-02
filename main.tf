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
}

resource "devzero_cluster" "cluster" {
  name = var.cluster_name
}

resource "helm_release" "zxporter" {
  name             = "zxporter"
  chart            = "zxporter"
  repository       = "oci://registry-1.docker.io/devzeroinc"
  namespace        = "devzero-zxporter"
  create_namespace = true
  atomic           = true
  wait             = true
  version          = "0.0.14"

  set = concat([
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
      value = tostring(var.provision_prometheus)
    },
    {
      name  = "zxporter.dakrUrl"
      value = var.endpoint
    }
  ], var.zxporter_extra_values)

  set_sensitive = [
    {
      name  = "zxporter.clusterToken"
      value = devzero_cluster.cluster.token
    }
  ]

  depends_on = [devzero_cluster.cluster]
}

resource "helm_release" "devzero_operator" {
  name             = "devzero-operator"
  chart            = "dakr-operator"
  repository       = "oci://registry-1.docker.io/devzeroinc"
  namespace        = "devzero"
  create_namespace = true
  atomic           = true
  wait             = true
  version          = "0.1.3"

  set = concat([
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
    },
  ], var.operator_extra_values)

  set_sensitive = [
    {
      name  = "operator.clusterToken"
      value = devzero_cluster.cluster.token
    },
    {
      name  = "scheduler.controlPlaneToken"
      value = devzero_cluster.cluster.token
    }
  ]

  depends_on = [devzero_cluster.cluster]
}