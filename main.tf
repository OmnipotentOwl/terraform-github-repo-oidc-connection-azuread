locals {
  repo_environments = distinct(flatten([
    for repo in var.github_repos : [
      for environment in repo.environment_names : {
        key                = "${repo.repository_name}_${environment}"
        repository_name    = repo.repository_name
        environment_name   = environment
        create_environment = repo.create_environments
      }
    ]
  ]))
  repo_branches = distinct(flatten([
    for repo in var.github_repos : [
      for branch in repo.branch_names : {
        key             = "${repo.repository_name}_${branch}"
        repository_name = repo.repository_name
        branch_name     = branch
      }
    ]
  ]))
  repo_tags = distinct(flatten([
    for repo in var.github_repos : [
      for tag in repo.tag_names : {
        key             = "${repo.repository_name}_${tag}"
        repository_name = repo.repository_name
        tag_name        = tag
      }
    ]
  ]))
  well_known_application_permissions = var.well_known_application_permissions == null ? [] : var.well_known_application_permissions
}


data "github_organization" "current" {
  name = var.github_organization
}
