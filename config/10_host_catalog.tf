resource "boundary_host_catalog" "consul" {
  name        = "test"
  description = "test catalog"


  scope_id = boundary_scope.project.id
  type     = "static"
}

resource "boundary_host" "consul_nodes" {
  count           = length(data.consul_nodes.nodes)
  name            = data.consul_nodes.nodes.nodes[count.index].name
  type            = "static"
  host_catalog_id = boundary_host_catalog.consul.id
  address         = contains(keys(data.consul_nodes.nodes.nodes[count.index].meta), "host-ip") ? data.consul_nodes.nodes.nodes[count.index].meta.host-ip : "255.255.255.255"
}

resource "boundary_host_set" "consul_nodes_set" {
  count           = length(boundary_host.consul_nodes)
  name            = boundary_host.consul_nodes[count.index].name
  host_catalog_id = boundary_host_catalog.consul.id
  type            = "static"
  host_ids        = [boundary_host.consul_nodes[count.index].id]
}

resource "boundary_target" "consul_node_target" {
  count        = length(boundary_host_set.consul_nodes_set)
  name         = boundary_host_set.consul_nodes_set[count.index].name
  type         = "tcp"
  default_port = "22"
  scope_id     = boundary_scope.project.id
  host_source_ids = [
    boundary_host_set.consul_nodes_set[count.index].id
  ]
}
