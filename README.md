# terraform-vsphere-windows-vm
Deploy Windows virtual machine to vSphere cluster (from template)

Terraform (tested) version: 0.12.16

## Using the module (from github)
1. Use the following module-block in your terraform-code:
```hcl
module "my_module_name" {
  source "github.com:www-aiqu-no/terraform-vsphere-windows-vm.git?ref=v0.0.2"
  ...
}
```
2. Optionally add 'ref' tag corresponding with a valid release-tag
3. Run 'terraform get' to download module

See 'example' folder & variables for configuration-options
