variable "release_name" {
  type        = string
  description = "Helm release name"
  default     = "zxporter"
}

variable "chart_name" {
  type        = string
  description = "Helm chart name"
  default     = "zxporter"
}

variable "chart_repository" {
  type        = string
  description = "Helm chart repository URL"
  default     = "oci://registry-1.docker.io/devzeroinc"
}

variable "chart_version" {
  type        = string
  description = "Helm chart version"
  default     = "0.0.22"
}

variable "namespace" {
  type        = string
  description = "Kubernetes namespace to install the chart in"
  default     = "devzero-zxporter"
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
}

variable "enable_prometheus" {
  type        = bool
  description = "Enable Prometheus monitoring"
  default     = true
}