# Terraform module for adding a cluster to your devzero account

[Website](https://devzero.io/dashboard)

[Docs](https://docs.devzero.io)

## Using the module

A module to add a cluster to your devzero account

Requires `devzero-inc/devzero` and `hashicorp/helm`

```hcl
terraform {
    required_providers {
        devzero = {
            source  = "devzero-inc/devzero"
            version = ">= 0.3.0"
        }
    }
}

provider "devzero" {
    team_id = "YOUR_TEAM_ID"
    token = "YOUR_SERVICE_ACCOUNT_TOKEN"
}

module "devzero-cluster" {
    source  = "devzero-inc/cluster/devzero"
    version = "~> 0.2"

    cluster_name = "example-cluster"
}
```

Drive the provider with a service account's token (`dzs-`). The provider accepts a person's token, but with it destroying a `devzero_team` is that person's leave of the team: a last member's leave deletes the team, unless DevZero refuses it, as it does once a cluster in the team has reported.

### A partner's customer cluster

A partner starts a team for its customer and registers the customer's cluster in it. The provider runs as the partner's team. `member_emails` must name a person who is Admin of the partner's team: the service account joins the new team as Developer, and a start with no person as Admin is refused.

```hcl
terraform {
    required_providers {
        devzero = {
            source  = "devzero-inc/devzero"
            version = ">= 0.3.0"
        }
    }
}

provider "devzero" {
    team_id = "PARTNER_TEAM_ID"
    token = "YOUR_SERVICE_ACCOUNT_TOKEN"
}

resource "devzero_team" "acme" {
    name                = "Acme"
    member_emails       = ["alice@partner.example"]
    admin_invite_emails = ["admin@acme.example"]
}

module "acme-cluster" {
    source  = "devzero-inc/cluster/devzero"
    version = "~> 0.2"

    cluster_name = "acme-prod"
    team_id      = devzero_team.acme.id
}
```

`team_id` is fixed once the cluster is registered. Moving a `devzero_team` into a module, or renaming it, needs a `moved` block; see the provider's `devzero_team` docs.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.1.0 |
| <a name="requirement_devzero"></a> [devzero](#requirement\_devzero) | >= 0.3.0 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | >= 3.0.2 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | >= 2.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_devzero"></a> [devzero](#provider\_devzero) | >= 0.3.0 |
| <a name="provider_helm"></a> [helm](#provider\_helm) | 3.1.1 |
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | >= 2.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [devzero_cluster.cluster](https://registry.terraform.io/providers/devzero-inc/devzero/latest/docs/resources/cluster) | resource |
| [helm_release.devzero_operator](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [helm_release.zxporter](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [kubernetes_namespace_v1.this](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace_v1) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cloud_provider"></a> [cloud\_provider](#input\_cloud\_provider) | The cloud provider of the cluster. Supported values: aws, azure, gcp, "". Empty string will be treated as no cloud credentials are required. | `string` | `""` | no |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | The name of the cluster | `string` | n/a | yes |
| <a name="input_containerd_config_path"></a> [containerd\_config\_path](#input\_containerd\_config\_path) | The path to the containerd config | `string` | `null` | no |
| <a name="input_containerd_socket_path"></a> [containerd\_socket\_path](#input\_containerd\_socket\_path) | The path to the containerd socket | `string` | `null` | no |
| <a name="input_create_namespace"></a> [create\_namespace](#input\_create\_namespace) | Whether this module creates the namespace. Set false when the caller manages it. | `bool` | `true` | no |
| <a name="input_enable_live_migration_agent"></a> [enable\_live\_migration\_agent](#input\_enable\_live\_migration\_agent) | Whether to enable the live migration agent | `bool` | `false` | no |
| <a name="input_enable_operator"></a> [enable\_operator](#input\_enable\_operator) | Whether to install the devzero-operator component | `bool` | `true` | no |
| <a name="input_enable_scheduler"></a> [enable\_scheduler](#input\_enable\_scheduler) | Whether to enable the scheduler | `bool` | `true` | no |
| <a name="input_enable_zxporter"></a> [enable\_zxporter](#input\_enable\_zxporter) | Whether to install the zxporter component | `bool` | `true` | no |
| <a name="input_endpoint"></a> [endpoint](#input\_endpoint) | The endpoint of the control plane | `string` | `"https://dakr.devzero.io"` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | Namespace for zxporter and devzero-operator. | `string` | `"devzero-system"` | no |
| <a name="input_operator_chart_version"></a> [operator\_chart\_version](#input\_operator\_chart\_version) | The Helm chart version for devzero-operator | `string` | `"0.1.49"` | no |
| <a name="input_operator_extra_values"></a> [operator\_extra\_values](#input\_operator\_extra\_values) | Additional Helm values for the devzero-operator chart (as name->value). | <pre>list(object({<br>    name  = string<br>    value = string<br>  }))</pre> | `[]` | no |
| <a name="input_provision_prometheus"></a> [provision\_prometheus](#input\_provision\_prometheus) | Whether to provision prometheus | `bool` | `true` | no |
| <a name="input_runtime"></a> [runtime](#input\_runtime) | The runtime of the cluster. Supported values: containerd, rke2, k3s. | `string` | `"containerd"` | no |
| <a name="input_team_id"></a> [team\_id](#input\_team\_id) | ID of the DevZero team the cluster is registered in, such as a devzero\_team's id. Unset, the cluster registers in the provider's team\_id. It is fixed once the cluster is registered: a change is refused at plan, so the module never moves or re-creates a cluster. | `string` | `null` | no |
| <a name="input_zxporter_chart_version"></a> [zxporter\_chart\_version](#input\_zxporter\_chart\_version) | The Helm chart version for zxporter | `string` | `"0.0.59"` | no |
| <a name="input_zxporter_extra_values"></a> [zxporter\_extra\_values](#input\_zxporter\_extra\_values) | Additional Helm values for the zxporter chart (as name->value). | <pre>list(object({<br>    name  = string<br>    value = string<br>  }))</pre> | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cluster_id"></a> [cluster\_id](#output\_cluster\_id) | n/a |
| <a name="output_cluster_token"></a> [cluster\_token](#output\_cluster\_token) | n/a |
<!-- END_TF_DOCS -->