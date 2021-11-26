terraform {
  backend "consul" {
    address = "consul.home.lan"
    scheme  = "https"
    path    = "terraform/local"
  }
}

provider "consul" {
  address    = "consul.home.lan:443"
  datacenter = "dc1"
  scheme     = "https"
}
