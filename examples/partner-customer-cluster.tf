# Example: A partner starts a customer's team and registers the customer's
# cluster in it. The provider runs as the partner's team, with a service
# account's token (dzs-). A person's token is accepted, but destroying a
# devzero_team with it is that person's leave, and a last member's leave
# deletes the team.
terraform {
  required_providers {
    devzero = {
      source  = "devzero-inc/devzero"
      version = ">= 0.3.0"
    }
  }
}

variable "partner_team_id" {
  type = string
}

variable "partner_service_account_token" {
  type      = string
  sensitive = true
}

provider "devzero" {
  team_id = var.partner_team_id
  token   = var.partner_service_account_token
}

# member_emails must name a person who is Admin of the partner's team: the
# service account joins as Developer, and a start with no person as Admin is
# refused.
resource "devzero_team" "acme" {
  name                = "Acme"
  member_emails       = ["alice@partner.example"]
  admin_invite_emails = ["admin@acme.example"]
}

module "devzero_cluster" {
  source = "../"

  cluster_name = "acme-prod"
  team_id      = devzero_team.acme.id
}
