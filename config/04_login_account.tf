resource "boundary_account" "myuser" {
  name           = "jacob"
  description    = "User account for my user"
  type           = "password"
  login_name     = "jacob"
  password       = var.admin_password
  auth_method_id = boundary_auth_method.password.id
}

