variable "cluster_name" {
  type        = string
  description = "The name of the cluster"
}

variable "endpoint" {
  type        = string
  description = "The endpoint of the control plane"
  default     = "https://dakr.devzero.io"
}

variable "enable_zxporter" {
  type        = bool
  description = "Whether to install the zxporter component"
  default     = true
}

variable "enable_operator" {
  type        = bool
  description = "Whether to install the devzero-operator component"
  default     = true
}

variable "cloud_provider" {
  type        = string
  description = "The cloud provider of the cluster. Supported values: aws, azure, gcp, \"\". Empty string will be treated as no cloud credentials are required."
  default     = ""

  validation {
    condition     = contains(["aws", "azure", "gcp", ""], var.cloud_provider)
    error_message = "cloud_provider must be one of: aws, azure, gcp, or empty string (\"\")."
  }
}

variable "provision_prometheus" {
  type        = bool
  description = "Whether to provision prometheus"
  default     = true
}

variable "enable_scheduler" {
  type        = bool
  description = "Whether to enable the scheduler"
  default     = true
}

variable "enable_live_migration_agent" {
  type        = bool
  description = "Whether to enable the live migration agent"
  default     = false
}

variable "runtime" {
  type        = string
  description = "The runtime of the cluster. Supported values: containerd, rke2, k3s."
  default     = "containerd"

  validation {
    condition     = contains(["containerd", "rke2", "k3s"], var.runtime)
    error_message = "runtime must be one of: containerd, rke2, k3s."
  }
}

variable "containerd_config_path" {
  type        = string
  description = "The path to the containerd config"
  default     = null
}

variable "containerd_socket_path" {
  type        = string
  description = "The path to the containerd socket"
  default     = null
}

variable "zxporter_extra_values" {
  type = list(object({
    name  = string
    value = string
  }))
  description = "Additional Helm values for the zxporter chart (as name->value)."
  default     = []
}

variable "operator_extra_values" {
  type = list(object({
    name  = string
    value = string
  }))
  description = "Additional Helm values for the devzero-operator chart (as name->value)."
  default     = []
}

variable "zxporter_chart_version" {
  type        = string
  description = "The Helm chart version for zxporter"
  default     = "0.0.26"
}

variable "operator_chart_version" {
  type        = string
  description = "The Helm chart version for devzero-operator"
  default     = "0.1.14"
}
