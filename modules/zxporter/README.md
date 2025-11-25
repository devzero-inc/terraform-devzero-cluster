<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | >= 2.0.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_helm"></a> [helm](#provider\_helm) | >= 2.0.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [helm_release.zxporter](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_atomic"></a> [atomic](#input\_atomic) | If true, installation process will purge the chart on fail | `bool` | `true` | no |
| <a name="input_chart_name"></a> [chart\_name](#input\_chart\_name) | Helm chart name | `string` | `"zxporter"` | no |
| <a name="input_chart_repository"></a> [chart\_repository](#input\_chart\_repository) | Helm chart repository URL | `string` | `"oci://registry-1.docker.io/devzeroinc"` | no |
| <a name="input_chart_version"></a> [chart\_version](#input\_chart\_version) | Helm chart version | `string` | `"0.0.22"` | no |
| <a name="input_cloud_provider"></a> [cloud\_provider](#input\_cloud\_provider) | Cloud provider (aws, azure, gcp, or empty string) | `string` | `""` | no |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | DevZero cluster name | `string` | `null` | no |
| <a name="input_cluster_token"></a> [cluster\_token](#input\_cluster\_token) | DevZero cluster token (typically passed as sensitive value) | `string` | `null` | no |
| <a name="input_create_namespace"></a> [create\_namespace](#input\_create\_namespace) | Create the namespace if it doesn't exist | `bool` | `true` | no |
| <a name="input_enable_prometheus"></a> [enable\_prometheus](#input\_enable\_prometheus) | Enable Prometheus monitoring | `bool` | `true` | no |
| <a name="input_endpoint"></a> [endpoint](#input\_endpoint) | DevZero endpoint URL | `string` | `"https://dakr.devzero.io"` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | Kubernetes namespace to install the chart in | `string` | `"devzero-zxporter"` | no |
| <a name="input_release_name"></a> [release\_name](#input\_release\_name) | Helm release name | `string` | `"zxporter"` | no |
| <a name="input_set_sensitive_values"></a> [set\_sensitive\_values](#input\_set\_sensitive\_values) | List of sensitive Helm values to set | <pre>list(object({<br>    name  = string<br>    value = string<br>    type  = optional(string)<br>  }))</pre> | `[]` | no |
| <a name="input_set_values"></a> [set\_values](#input\_set\_values) | List of Helm values to set | <pre>list(object({<br>    name  = string<br>    value = string<br>    type  = optional(string)<br>  }))</pre> | `[]` | no |
| <a name="input_values_yaml"></a> [values\_yaml](#input\_values\_yaml) | Full YAML values to pass to the Helm chart. If provided, this overrides all other value settings | `string` | `null` | no |
| <a name="input_wait"></a> [wait](#input\_wait) | Will wait until all resources are in a ready state before marking the release as successful | `bool` | `true` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_release_name"></a> [release\_name](#output\_release\_name) | The name of the Helm release |
| <a name="output_release_namespace"></a> [release\_namespace](#output\_release\_namespace) | The namespace of the Helm release |
| <a name="output_release_status"></a> [release\_status](#output\_release\_status) | Status of the Helm release |
| <a name="output_release_values"></a> [release\_values](#output\_release\_values) | The computed values of the Helm release |
| <a name="output_release_version"></a> [release\_version](#output\_release\_version) | The version of the Helm release |
<!-- END_TF_DOCS -->