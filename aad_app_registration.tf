data "azuread_application_published_app_ids" "well_known" {}

data "azuread_service_principal" "well_known" {
  for_each = { for app in var.well_known_application_permissions : app.name => app.name }

  application_id = data.azuread_application_published_app_ids.well_known.result[each.key]
}

resource "azuread_application" "github_oidc_app" {
  display_name     = var.connection_name
  sign_in_audience = "AzureADMyOrg"


  dynamic "required_resource_access" {
    for_each = var.well_known_application_permissions
    content {
      resource_app_id = data.azuread_application_published_app_ids.well_known.result[required_resource_access.value.name]
      dynamic "resource_access" {
        for_each = required_resource_access.value.permissions
        content {
          id   = resource_access.value.type == "Role" ? data.azuread_service_principal.well_known[required_resource_access.value.name].app_role_ids[resource_access.value.name] : data.azuread_service_principal.well_known[required_resource_access.value.name].oauth2_permission_scope_ids[resource_access.value.name]
          type = resource_access.value.type
        }
      }
    }
  }

  lifecycle {
    ignore_changes = [
      owners
    ]
  }
}

resource "azuread_service_principal" "github_oidc_app" {
  application_id               = azuread_application.github_oidc_app.application_id
  app_role_assignment_required = false
  lifecycle {
    ignore_changes = [
      owners
    ]
  }
}


resource "azuread_application_federated_identity_credential" "pull_request" {
  for_each = { for repo in var.github_repos : repo.repository_name => repo if repo.enable_pull_requests }

  application_object_id = azuread_application.github_oidc_app.object_id
  display_name          = "${each.value.repository_name}-pull_request"
  description           = "${data.github_organization.current.orgname}-${each.value.repository_name}-pull_request"
  audiences             = ["api://AzureADTokenExchange"]
  issuer                = "https://token.actions.githubusercontent.com"
  subject               = "repo:${data.github_organization.current.orgname}/${each.value.repository_name}:pull_request"
}

resource "azuread_application_federated_identity_credential" "repo_environments" {
  for_each = { for key, value in local.repo_environments : key => value }

  application_object_id = azuread_application.github_oidc_app.object_id
  display_name          = "${each.value.repository_name}-${each.value.environment_name}"
  description           = "${data.github_organization.current.orgname}-${each.value.repository_name}-${each.value.environment_name}"
  audiences             = ["api://AzureADTokenExchange"]
  issuer                = "https://token.actions.githubusercontent.com"
  subject               = "repo:${data.github_organization.current.orgname}/${each.value.repository_name}:environment:${each.value.environment_name}"
}

resource "azuread_application_federated_identity_credential" "repo_branches" {
  for_each = { for key, value in local.repo_branches : key => value }

  application_object_id = azuread_application.github_oidc_app.object_id
  display_name          = "${each.value.repository_name}-${each.value.branch_name}"
  description           = "${data.github_organization.current.orgname}-${each.value.repository_name}-${each.value.branch_name}"
  audiences             = ["api://AzureADTokenExchange"]
  issuer                = "https://token.actions.githubusercontent.com"
  subject               = "repo:${data.github_organization.current.orgname}/${each.value.repository_name}:ref:refs/heads/${each.value.branch_name}"
}

resource "azuread_application_federated_identity_credential" "repo_tags" {
  for_each = { for key, value in local.repo_tags : key => value }

  application_object_id = azuread_application.github_oidc_app.object_id
  display_name          = "${each.value.repository_name}-${each.value.tag_name}"
  description           = "${data.github_organization.current.orgname}-${each.value.repository_name}-${each.value.tag_name}"
  audiences             = ["api://AzureADTokenExchange"]
  issuer                = "https://token.actions.githubusercontent.com"
  subject               = "repo:${data.github_organization.current.orgname}/${each.value.repository_name}:ref:refs/tags/${each.value.tag_name}"
}
