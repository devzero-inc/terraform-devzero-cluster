output "release_name" {
  value       = helm_release.devzero_operator.name
  description = "The name of the Helm release"
}

output "release_namespace" {
  value       = helm_release.devzero_operator.namespace
  description = "The namespace of the Helm release"
}

output "release_status" {
  value       = helm_release.devzero_operator.status
  description = "Status of the Helm release"
}

output "release_version" {
  value       = helm_release.devzero_operator.version
  description = "The version of the Helm release"
}

output "release_values" {
  value       = helm_release.devzero_operator.values
  description = "The computed values of the Helm release"
  sensitive   = true
}