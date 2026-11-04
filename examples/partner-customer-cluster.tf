# Example: A partner starts a customer's team and registers the customer's
# cluster in it. The provider runs as the partner's team, with a service
# account's token (dzs-), not a person's.
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

resource "devzero_team" "acme" {
  name                = "Acme"
  member_emails       = ["alice@partner.example"]
  admin_invite_emails = ["admin@acme.example"]
}

module "devzero_cluster" {
  source = ".."

  cluster_name = "acme-prod"
  team_id      = devzero_team.acme.id
}
