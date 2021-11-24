terraform {
  backend "consul" {
    address   = "consul.home.lan"
    scheme    = "https"
    path      = "terraform/local"
  }
}
