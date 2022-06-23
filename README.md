# Terraform newrelic CPM Module

A Terraform module which creates high available containerized private minion on AWS.

## Usage

```hcl
module "newrelic_cpm_ha" {
  source                                   = "github.com/inthepocket/terraform-newrelic-cpm-ha"
  version                                  = "0.1.0"
  newrelic_private_location_key            = "locationkey"
  vpc_id                                   = "VPCID"
  vpc_subnet_id                            = "VPCSUBNETID"
  newrelic_cpm_manager_volume_size         = 20 #optional
  min_instances                            = 2 #optional
  max_instances                            = 3 #optional
}
```
