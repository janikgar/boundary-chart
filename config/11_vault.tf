resource "boundary_credential_store_vault" "vault" {
  name     = "vault_store"
  address  = "http://vault.vault.svc.cluster.local:8200"
  token    = var.vault_token
  scope_id = boundary_scope.project.id
}
