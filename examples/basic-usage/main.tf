# Basic usage - maintains backward compatibility
module "devzero_cluster" {
  source = "../.."
  
  cluster_name = "my-cluster"
  cloud_provider = "aws"
  
  # Optional customizations
  enable_scheduler = true
  enable_live_migration_agent = false
  provision_prometheus = true
}