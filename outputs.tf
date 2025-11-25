output "cluster_id" {
  value       = module.cluster.cluster_id
  description = "The ID of the created cluster"
}

output "cluster_token" {
  value       = module.cluster.cluster_token
  sensitive   = true
  description = "The token for the created cluster"
}