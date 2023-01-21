data "github_repository" "repos" {
  for_each = { for repo in var.github_repos : repo.repository_name => repo }

  full_name = "${data.github_organization.current.orgname}/${each.value.repository_name}"
}

resource "github_repository_environment" "azure_environments" {
  for_each = { for repo_env in local.repo_environments : repo_env.key => repo_env if repo_env.create_environment }

  environment = each.value.environment_name
  repository  = data.github_repository.repos[each.value.repository_name].name
  lifecycle {
    ignore_changes = [
      wait_timer,
      reviewers,
      deployment_branch_policy
    ]
  }
}

resource "github_actions_environment_secret" "environment_client_id" {
  for_each = { for repo_env in local.repo_environments : repo_env.key => repo_env }

  repository      = data.github_repository.repos[each.value.repository_name].name
  environment     = each.value.environment_name
  secret_name     = "AZURE_CLIENT_ID"
  plaintext_value = azuread_application.github_oidc_app.application_id

  depends_on = [
    github_repository_environment.azure_environments
  ]
}

resource "github_actions_environment_secret" "environment_subscription_id" {
  for_each = { for repo_env in local.repo_environments : repo_env.key => repo_env }

  repository      = data.github_repository.repos[each.value.repository_name].name
  environment     = each.value.environment_name
  secret_name     = "AZURE_SUBSCRIPTION_ID"
  plaintext_value = var.subscription_id

  depends_on = [
    github_repository_environment.azure_environments
  ]
}

resource "github_actions_secret" "repo_client_id" {
  for_each = { for repo in var.github_repos : repo.repository_name => repo if length(repo.branch_names) > 0 || length(repo.tag_names) > 0 || repo.enable_pull_requests }

  repository      = data.github_repository.repos[each.value.repository_name].name
  secret_name     = "AZURE_CLIENT_ID"
  plaintext_value = azuread_application.github_oidc_app.application_id
}

resource "github_actions_secret" "repo_subscription_id" {
  for_each = { for repo in var.github_repos : repo.repository_name => repo if length(repo.branch_names) > 0 || length(repo.tag_names) > 0 || repo.enable_pull_requests }

  repository      = data.github_repository.repos[each.value.repository_name].name
  secret_name     = "AZURE_SUBSCRIPTION_ID"
  plaintext_value = var.subscription_id
}
