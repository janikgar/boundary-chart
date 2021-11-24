resource "boundary_user" "myuser" {
  name        = "myuser"
  description = "My user!"
  account_ids = [boundary_account.myuser.id]
  scope_id    = boundary_scope.org.id
}

