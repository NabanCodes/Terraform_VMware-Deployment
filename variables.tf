variable "vsphere_user" {
  description = "vCenter username."
  type        = string
}

variable "vsphere_password" {
  description = "vCenter password."
  type        = string
  sensitive   = true
}

variable "vsphere_server" {
  description = "vCenter FQDN or IP address."
  type        = string
}

variable "allow_unverified_ssl" {
  description = "Allow the provider to connect to vCenter with an untrusted certificate."
  type        = bool
  default     = false
}

variable "datacenter" {
  description = "vSphere datacenter containing the target resources."
  type        = string
}

variable "cluster" {
  description = "vSphere compute cluster used for the VM."
  type        = string
}

variable "datastore" {
  description = "Datastore used for the VM disks."
  type        = string
}

variable "network" {
  description = "Port group or network name for the VM NIC."
  type        = string
}

variable "iso_path" {
  description = "Datastore-relative path to the installation ISO, for example ISO/ubuntu-22.04-live-server-amd64.iso."
  type        = string
}

variable "guest_id" {
  description = "VMware guest operating system identifier, for example ubuntu64Guest or otherLinux64Guest."
  type        = string
}

variable "vm_name" {
  description = "Name and hostname of the new VM."
  type        = string
}

variable "cpu_count" {
  description = "Number of virtual CPUs."
  type        = number
  default     = 2

  validation {
    condition     = var.cpu_count > 0
    error_message = "cpu_count must be greater than zero."
  }
}

variable "memory_mb" {
  description = "VM memory in megabytes."
  type        = number
  default     = 4096

  validation {
    condition     = var.memory_mb >= 512
    error_message = "memory_mb must be at least 512 MB."
  }
}

variable "disk_size_gb" {
  description = "Requested OS disk size in gigabytes; it cannot shrink the template disk."
  type        = number
  default     = 40

  validation {
    condition     = var.disk_size_gb > 0
    error_message = "disk_size_gb must be greater than zero."
  }
}
