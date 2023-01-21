output "connection_sp_client_id" {
  value       = azuread_application.github_oidc_app.application_id
  description = "The client ID of the service principal for the connection."
  sensitive   = true
}
output "connection_sp_object_id" {
  value       = azuread_service_principal.github_oidc_app.object_id
  description = "The object ID of the service principal for the connection."
}
output "connection_subscription_id" {
  value       = var.subscription_id
  description = "The default subscription ID for the connection."
}
