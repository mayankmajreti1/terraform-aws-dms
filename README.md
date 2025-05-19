# terraform-aws-dms

[![Lint Status](https://github.com/tothenew/terraform-aws-dms/workflows/Lint/badge.svg)](https://github.com/tothenew/terraform-aws-dms/actions)
[![LICENSE](https://img.shields.io/github/license/tothenew/terraform-aws-dms)](https://github.com/tothenew/terraform-aws-dms/blob/master/LICENSE)

This module provisions and configures Amazon MQ for dms, enabling secure and scalable message brokering within a region.

The following resources will be created:
- Brokers
- Configurations

## Usages
```
module "dms {
  source                        =   "./module/dms"
  repl_subnet_group_subnet_ids  =   ["subnet-123456789","subnet-987654321"]
  repl_instance_engine_version  =   "3.5.4"
  source_endpoint               =   var.source_endpoint
  destination_endpoint          =   var.destination_endpoint

  replication_task  = {
    replication_task_id       = "example-cdc"
    migration_type            = "cdc"
    replication_task_settings = "./task_settings.json"
    table_mappings            = "./table_mappings.json"
    source_endpoint_key       = "source"
    target_endpoint_key       = "destination"
  }

  event_subscriptions           =   var.event_subscriptions
}
```

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_active-mq"></a> [active\_mq](#module\_active\_mq) | ./module/active-mq | n/a |

## Resources

| Name | Type |
|------|------|


## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|

## Outputs

| Name | Description |
|------|-------------|


## Authors

Module managed by [TO THE NEW Pvt. Ltd.](https://github.com/tothenew)

## License

Apache 2 Licensed. See [LICENSE](https://github.com/tothenew/terraform-aws-dms/blob/main/LICENSE) for full details.