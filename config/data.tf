data "consul_nodes" "nodes" {
  query_options {
    datacenter = "dc1"
  }
}

