provider "vsphere" {
    user           = "user"
    password       = "pass"
    vsphere_server = "x.x.x.x"

    # If you have a self-signed cert
    allow_unverified_ssl = true
}

variable  "vm_name"{
  default =  "test machine"
}

variable  "vm_cpu"{
  default =  "1"
}

variable  "vm_ram"{
  default =  "1"
}

data "vsphere_datacenter" "dc" {
      name = "Datacenter Name"
}

data "vsphere_datastore" "datastore" {
      name          = "datastore"
      datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

data "vsphere_compute_cluster" "cluster" {
      name          = "Cluster Name"
      datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

data "vsphere_resource_pool" "pool" {
      name          = "pool-terraform"
      datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

data "vsphere_network" "network" {
      name          = "VM Network"
      datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

data "vsphere_virtual_machine" "template" {
      name          = "Template Name"
      datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

resource "vsphere_virtual_machine" "vm" {
      name             = "${var.vm_name}"
      resource_pool_id = "${data.vsphere_resource_pool.pool.id}"
      datastore_id     = "${data.vsphere_datastore.datastore.id}"

      num_cpus = "${var.vm_cpu}"
      memory   = "${var.vm_ram}"
      guest_id = "${data.vsphere_virtual_machine.template.guest_id}"

      disk {
        size  = 40
        label = "test"
        eagerly_scrub    = false
        thin_provisioned = true
      }

      network_interface {
        network_id = "${data.vsphere_network.network.id}"
        adapter_type   = "vmxnet3"
      }
      clone {
        template_uuid = "${data.vsphere_virtual_machine.template.id}"
      }
}
