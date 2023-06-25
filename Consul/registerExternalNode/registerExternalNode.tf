# Specify the Consul provider source and version
terraform {
  required_providers {
    consul = {
      source = "hashicorp/consul"
      version = "2.14.0"
    }
  }
}

# Configure the Consul provider
provider "consul" {
  address    = "${var.consulAddress}"
  datacenter = "${var.dc}"
}


# Register external node - rezaTEST
resource "consul_node" "nodename" {
  name    = "${var.nodeName}"
  address = "${var.nodeAddress}"

  meta = {
    "external-node"  = "true"
    "external-probe" = "true"
  }
}

# Register service in consul
resource "consul_service" "servicename" {
  name          = "${var.serviceName}"
  node          = consul_node.nodename.name
  port          = "${var.portNumber}"

    meta = {
    "external-node"  = "true"
    "external-probe" = "true"
  }
}
