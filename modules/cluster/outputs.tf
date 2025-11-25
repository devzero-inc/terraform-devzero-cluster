output "cluster_id" {
  value       = devzero_cluster.cluster.id
  description = "The ID of the created cluster"
}

output "cluster_token" {
  value       = devzero_cluster.cluster.token
  sensitive   = true
  description = "The token for the created cluster"
}

output "cluster_name" {
  value       = var.cluster_name
  description = "The name of the cluster"
}