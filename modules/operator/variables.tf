variable "release_name" {
  type        = string
  description = "Helm release name"
  default     = "devzero-operator"
}

variable "chart_name" {
  type        = string
  description = "Helm chart name"
  default     = "dakr-operator"
}

variable "chart_repository" {
  type        = string
  description = "Helm chart repository URL"
  default     = "oci://registry-1.docker.io/devzeroinc"
}

variable "chart_version" {
  type        = string
  description = "Helm chart version"
  default     = "0.1.9"
}

variable "namespace" {
  type        = string
  description = "Kubernetes namespace to install the chart in"
  default     = "devzero"
}

variable "create_namespace" {
  type        = bool
  description = "Create the namespace if it doesn't exist"
  default     = true
}

variable "atomic" {
  type        = bool
  description = "If true, installation process will purge the chart on fail"
  default     = true
}

variable "wait" {
  type        = bool
  description = "Will wait until all resources are in a ready state before marking the release as successful"
  default     = true
}

variable "values_yaml" {
  type        = string
  description = "Full YAML values to pass to the Helm chart. If provided, this overrides all other value settings"
  default     = null
}

variable "set_values" {
  type = list(object({
    name  = string
    value = string
    type  = optional(string)
  }))
  description = "List of Helm values to set"
  default     = []
}

variable "set_sensitive_values" {
  type = list(object({
    name  = string
    value = string
    type  = optional(string)
  }))
  description = "List of sensitive Helm values to set"
  default     = []
  sensitive   = true
}

# Convenience variables for common configurations
variable "cluster_token" {
  type        = string
  description = "DevZero cluster token (typically passed as sensitive value)"
  default     = null
  sensitive   = true
}

variable "cluster_name" {
  type        = string
  description = "DevZero cluster name"
  default     = null
}

variable "endpoint" {
  type        = string
  description = "DevZero endpoint URL"
  default     = "https://dakr.devzero.io"
}

variable "cloud_provider" {
  type        = string
  description = "Cloud provider (aws, azure, gcp, or empty string)"
  default     = ""

  validation {
    condition     = contains(["aws", "azure", "gcp", ""], var.cloud_provider)
    error_message = "cloud_provider must be one of: aws, azure, gcp, or empty string (\"\")."
  }
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