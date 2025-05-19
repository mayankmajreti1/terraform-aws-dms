# terraform-aws-dms

[![Lint Status](https://github.com/tothenew/terraform-aws-dms/workflows/Lint/badge.svg)](https://github.com/tothenew/terraform-aws-dms/actions)
[![LICENSE](https://img.shields.io/github/license/tothenew/terraform-aws-dms)](https://github.com/tothenew/terraform-aws-dms/blob/master/LICENSE)

This module provisions and configures **AWS Database Migration Service (DMS)** resources for securely and reliably migrating databases in AWS.

The following resources will be created:

* DMS Replication Subnet Group
* DMS Replication Instance
* DMS Endpoints

  * Source
  * Target
* DMS Replication Task
* DMS Event Subscriptions

## Usage

```hcl
module "dms" {
  source                        = "./module/dms"
  repl_subnet_group_subnet_ids = ["subnet-123456789", "subnet-987654321"]
  repl_instance_engine_version = "3.5.4"
  source_endpoint              = var.source_endpoint
  destination_endpoint         = var.destination_endpoint

  replication_task = {
    replication_task_id       = "example-cdc"
    migration_type            = "cdc"
    replication_task_settings = "./task_settings.json"
    table_mappings            = "./table_mappings.json"
    source_endpoint_key       = "source"
    target_endpoint_key       = "destination"
  }

  event_subscriptions = var.event_subscriptions
}
```

<!-- BEGIN_TF_DOCS -->

## Requirements

| Name      | Version  |
| --------- | -------- |
| terraform | >= 1.3.0 |

## Providers

| Name | Version |
| ---- | ------- |
| aws  | n/a     |

## Modules

| Name       | Source             | Version |
| ---------- | ------------------ | ------- |
| active\_mq | ./module/active-mq | n/a     |

## Resources

| Name                                      | Type     |
| ----------------------------------------- | -------- |
| aws\_dms\_replication\_subnet\_group.this | resource |
| aws\_dms\_replication\_instance.this      | resource |
| aws\_dms\_endpoint.source                 | resource |
| aws\_dms\_endpoint.target                 | resource |
| aws\_dms\_replication\_task.this          | resource |
| aws\_dms\_event\_subscription.this        | resource |

## Inputs

| Name                             | Description                                 | Type         | Default | Required |
| -------------------------------- | ------------------------------------------- | ------------ | ------- | :------: |
| repl\_subnet\_group\_subnet\_ids | Subnet IDs for the replication subnet group | list(string) | n/a     |    yes   |
| repl\_instance\_engine\_version  | Engine version of the replication instance  | string       | n/a     |    yes   |
| source\_endpoint                 | Configuration for source endpoint           | any          | n/a     |    yes   |
| destination\_endpoint            | Configuration for destination endpoint      | any          | n/a     |    yes   |
| replication\_task                | Details of the replication task             | map(any)     | n/a     |    yes   |
| event\_subscriptions             | List of DMS event subscriptions             | any          | `[]`    |    no    |

## Outputs

| Name                       | Description                         |
| -------------------------- | ----------------------------------- |
| replication\_instance\_arn | ARN of the DMS replication instance |
| source\_endpoint\_arn      | ARN of the DMS source endpoint      |
| target\_endpoint\_arn      | ARN of the DMS target endpoint      |
| replication\_task\_arn     | ARN of the DMS replication task     |

## Authors

Module managed by [TO THE NEW Pvt. Ltd.](https://github.com/tothenew)

## License

Apache 2 Licensed. See [LICENSE](https://github.com/tothenew/terraform-aws-dms/blob/main/LICENSE) for full details.
