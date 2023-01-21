variable "connection_name" {
  type        = string
  description = "The name of the connection."
}
variable "github_organization" {
  type        = string
  description = "The name of the GitHub organization to configure for use with the connection."
}
variable "github_repos" {
  type = list(object({
    repository_name      = string
    branch_names         = optional(list(string), [])
    environment_names    = optional(list(string), [])
    create_environments  = bool
    enable_pull_requests = bool
    tag_names            = optional(list(string), [])
  }))
  description = "The list of GitHub repositories to configure for use with the connection."
}
variable "subscription_id" {
  type        = string
  description = "The Azure Subscription ID to configure for use with the connection."
}
variable "well_known_application_permissions" {
  type = list(object({
    name = string
    permissions = list(object({
      name = string
      type = string
    }))
  }))
  description = "The list of well-known application permissions to configure for use with the connection."
  default     = []
}
