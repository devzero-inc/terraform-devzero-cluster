output "cluster_id" {
  value = devzero_cluster.cluster.id
}

output "cluster_token" {
  value     = devzero_cluster.cluster.token
  sensitive = true
}