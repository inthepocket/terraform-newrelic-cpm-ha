# Terraform newrelic CPM Module

A Terraform module which creates high available containerized private minion's in AWS.


## Why

This module was created for developers who want to run newrelic private minion's inside a AWS VPC without kubernetes.
It creates EC2 instances that run a docker container which polls for synthetics that are configured inside newrelic and are assigned to a private location.
The setup is high available as you want to rely on these machines for internal health checks.
More info: https://docs.newrelic.com/docs/synthetics/synthetic-monitoring/private-locations/install-containerized-private-minions-cpms

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
