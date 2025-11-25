# Example: Only create the DevZero cluster without any components
module "devzero_cluster" {
  source = ".."
  
  cluster_name = "minimal-cluster"
  
  # Disable both components
  enable_zxporter = false
  enable_operator = false
}

output "cluster_token" {
  value     = module.devzero_cluster.cluster_token
  sensitive = true
}