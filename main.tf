terraform {
	required_version = ">= 1.5.0"

	required_providers {
		vsphere = {
			source  = "hashicorp/vsphere"
			version = "~> 2.8"
		}
	}
}

provider "vsphere" {
	user                 = var.vsphere_user
	password             = var.vsphere_password
	vsphere_server       = var.vsphere_server
	allow_unverified_ssl = var.allow_unverified_ssl
}

data "vsphere_datacenter" "datacenter" {
	name = var.datacenter
}

data "vsphere_compute_cluster" "cluster" {
	name          = var.cluster
	datacenter_id = data.vsphere_datacenter.datacenter.id
}

data "vsphere_datastore" "datastore" {
	name          = var.datastore
	datacenter_id = data.vsphere_datacenter.datacenter.id
}

data "vsphere_network" "network" {
	name          = var.network
	datacenter_id = data.vsphere_datacenter.datacenter.id
}

resource "vsphere_virtual_machine" "vm" {
	name             = var.vm_name
	resource_pool_id = data.vsphere_compute_cluster.cluster.resource_pool_id
	datastore_id     = data.vsphere_datastore.datastore.id

	num_cpus = var.cpu_count
	memory   = var.memory_mb

	guest_id  = var.guest_id
	scsi_type = "lsilogic"

	cdrom {
		datastore_id = data.vsphere_datastore.datastore.id
		path         = var.iso_path
	}

	network_interface {
		network_id   = data.vsphere_network.network.id
		adapter_type = "vmxnet3"
	}

	disk {
		label            = "disk0"
		size             = var.disk_size_gb
		thin_provisioned = true
	}
}

output "vm_name" {
	description = "Name of the deployed virtual machine."
	value       = vsphere_virtual_machine.vm.name
}

output "vm_ip_address" {
	description = "IPv4 address reported by VMware Tools after customization."
	value       = vsphere_virtual_machine.vm.guest_ip_addresses[0]
}
