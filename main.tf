module "dms" {
  source = "./module/dms"

  # Subnet Group
  repl_subnet_group_name        = var.repl_subnet_group_name
  repl_subnet_group_description = var.repl_subnet_group_description
  repl_subnet_group_subnet_ids  = var.private_subnet_ids

  # Replication Instance
  repl_instance_allocated_storage            = var.repl_instance_allocated_storage
  repl_instance_auto_minor_version_upgrade   = var.repl_instance_auto_minor_version_upgrade
  repl_instance_allow_major_version_upgrade  = var.repl_instance_allow_major_version_upgrade
  repl_instance_apply_immediately            = var.repl_instance_apply_immediately
  repl_instance_engine_version               = var.repl_instance_engine_version
  repl_instance_multi_az                     = var.repl_instance_multi_az
  repl_instance_preferred_maintenance_window = var.repl_instance_preferred_maintenance_window
  repl_instance_publicly_accessible          = var.repl_instance_publicly_accessible
  repl_instance_class                        = var.repl_instance_class
  repl_instance_id                           = var.repl_instance_id
  repl_instance_vpc_security_group_ids       = [aws_security_group.dms_sg.id]

  # Endpoints
  source_endpoint      = var.source_endpoint
  destination_endpoint = var.destination_endpoint

  # Replication Task (with JSON files)
  replication_task = {
    replication_task_id       = var.replication_task.replication_task_id
    migration_type            = var.replication_task.migration_type
    replication_task_settings = var.replication_task.replication_task_settings
    table_mappings            = var.replication_task.table_mappings
    source_endpoint_key       = var.replication_task.source_endpoint_key
    target_endpoint_key       = var.replication_task.target_endpoint_key
    tags                      = var.replication_task.tags
  }

  # Event Subscriptions
  event_subscriptions = var.event_subscriptions

  # Tags
  tags = merge(var.common_tags, { Name = "${local.service_name_prefix}-dms" })
}