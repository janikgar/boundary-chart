resource "boundary_user" "myuser" {
  name        = "myuser"
  description = "Jacob Admin"
  account_ids = [boundary_account.myuser.id]
  scope_id    = boundary_scope.org.id
}

