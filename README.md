# Terraform VMware Deployment

This configuration creates a new VM in vCenter and attaches an installation ISO. The operating system installation is completed through the vSphere console unless the ISO supports unattended installation.

## Prerequisites

- Terraform 1.5 or newer
- vCenter access and the `hashicorp/vsphere` provider
- An ISO uploaded to the selected datastore
- A vSphere datacenter, compute cluster, datastore, and network

## Usage

1. Copy `terraform.tfvars.example` to `terraform.tfvars` and replace every example value.
2. Initialize Terraform:

	```bash
	terraform init
	```

3. Review the plan:

	```bash
	terraform plan -var-file=terraform.tfvars
	```

4. Deploy the VM:

	```bash
	terraform apply -var-file=terraform.tfvars
	```

Do not commit `terraform.tfvars`; it contains vCenter credentials. For automation, set sensitive values with `TF_VAR_vsphere_user` and `TF_VAR_vsphere_password` instead.

`iso_path` is relative to the datastore, not the local filesystem. For example, `ISO/ubuntu-22.04-live-server-amd64.iso` means the ISO is stored in the datastore's `ISO` folder. The `guest_id` value must match the operating system being installed.

After `terraform apply`, open the VM console in vCenter and install the operating system. For a hands-off deployment, use an unattended ISO or add a cloud-init, Kickstart, or Autoinstall workflow.