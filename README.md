# terraform-github-repo-oidc-connection-azuread
Terraform Module for deploying GitHub OIDC Connection to Azure via AzureAD

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.0 |
| <a name="requirement_azuread"></a> [azuread](#requirement\_azuread) | >= 2.31.0 |
| <a name="requirement_github"></a> [github](#requirement\_github) | >= 5.13.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azuread"></a> [azuread](#provider\_azuread) | 2.33.0 |
| <a name="provider_github"></a> [github](#provider\_github) | 5.16.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azuread_application.github_oidc_app](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/application) | resource |
| [azuread_application_federated_identity_credential.pull_request](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/application_federated_identity_credential) | resource |
| [azuread_application_federated_identity_credential.repo_branches](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/application_federated_identity_credential) | resource |
| [azuread_application_federated_identity_credential.repo_environments](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/application_federated_identity_credential) | resource |
| [azuread_application_federated_identity_credential.repo_tags](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/application_federated_identity_credential) | resource |
| [azuread_service_principal.github_oidc_app](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/service_principal) | resource |
| [github_actions_environment_secret.environment_client_id](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/actions_environment_secret) | resource |
| [github_actions_environment_secret.environment_subscription_id](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/actions_environment_secret) | resource |
| [github_actions_secret.repo_client_id](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/actions_secret) | resource |
| [github_actions_secret.repo_subscription_id](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/actions_secret) | resource |
| [github_repository_environment.azure_environments](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository_environment) | resource |
| [azuread_application_published_app_ids.well_known](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/application_published_app_ids) | data source |
| [azuread_service_principal.well_known](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/service_principal) | data source |
| [github_organization.current](https://registry.terraform.io/providers/integrations/github/latest/docs/data-sources/organization) | data source |
| [github_repository.repos](https://registry.terraform.io/providers/integrations/github/latest/docs/data-sources/repository) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_connection_name"></a> [connection\_name](#input\_connection\_name) | The name of the connection. | `string` | n/a | yes |
| <a name="input_github_organization"></a> [github\_organization](#input\_github\_organization) | The name of the GitHub organization to configure for use with the connection. | `string` | n/a | yes |
| <a name="input_github_repos"></a> [github\_repos](#input\_github\_repos) | The list of GitHub repositories to configure for use with the connection. | <pre>list(object({<br>    repository_name      = string<br>    branch_names         = optional(list(string), [])<br>    environment_names    = optional(list(string), [])<br>    create_environments  = bool<br>    enable_pull_requests = bool<br>    tag_names            = optional(list(string), [])<br>  }))</pre> | n/a | yes |
| <a name="input_subscription_id"></a> [subscription\_id](#input\_subscription\_id) | The Azure Subscription ID to configure for use with the connection. | `string` | n/a | yes |
| <a name="input_well_known_application_permissions"></a> [well\_known\_application\_permissions](#input\_well\_known\_application\_permissions) | The list of well-known application permissions to configure for use with the connection. | <pre>list(object({<br>    name = string<br>    permissions = list(object({<br>      name = string<br>      type = string<br>    }))<br>  }))</pre> | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_connection_sp_client_id"></a> [connection\_sp\_client\_id](#output\_connection\_sp\_client\_id) | The client ID of the service principal for the connection. |
| <a name="output_connection_sp_object_id"></a> [connection\_sp\_object\_id](#output\_connection\_sp\_object\_id) | The object ID of the service principal for the connection. |
| <a name="output_connection_subscription_id"></a> [connection\_subscription\_id](#output\_connection\_subscription\_id) | The default subscription ID for the connection. |
<!-- END_TF_DOCS -->
