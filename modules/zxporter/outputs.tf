output "release_name" {
  value       = helm_release.zxporter.name
  description = "The name of the Helm release"
}

output "release_namespace" {
  value       = helm_release.zxporter.namespace
  description = "The namespace of the Helm release"
}

output "release_status" {
  value       = helm_release.zxporter.status
  description = "Status of the Helm release"
}

output "release_version" {
  value       = helm_release.zxporter.version
  description = "The version of the Helm release"
}

output "release_values" {
  value       = helm_release.zxporter.values
  description = "The computed values of the Helm release"
  sensitive   = true
}