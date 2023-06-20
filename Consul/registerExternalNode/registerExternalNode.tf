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
  address    = "192.168.1.124"
  datacenter = "dc1"
}


# Register external node - rezaTEST
resource "consul_node" "rezaTEST" {
  name    = "rezaTEST"
  address = "localhost"

  meta = {
    "external-node"  = "true"
    "external-probe" = "true"
  }
}

# Register service in consul
resource "consul_service" "rezaTEST" {
  name          = "rezaTEST"
  node          = consul_node.rezaTEST.name
  port          = 8080

    meta = {
    "external-node"  = "true"
    "external-probe" = "true"
  }
}
