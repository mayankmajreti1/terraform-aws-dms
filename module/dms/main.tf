resource "aws_dms_replication_subnet_group" "this" {
  replication_subnet_group_id       = var.repl_subnet_group_name
  replication_subnet_group_description = var.repl_subnet_group_description
  subnet_ids                       = var.repl_subnet_group_subnet_ids
  tags                             = var.tags
}

resource "aws_dms_replication_instance" "this" {
  replication_instance_id           = var.repl_instance_id
  replication_instance_class        = var.repl_instance_class
  allocated_storage                 = var.repl_instance_allocated_storage
  vpc_security_group_ids            = var.repl_instance_vpc_security_group_ids
  replication_subnet_group_id       = aws_dms_replication_subnet_group.this.replication_subnet_group_id
  engine_version                    = var.repl_instance_engine_version
  publicly_accessible               = var.repl_instance_publicly_accessible
  multi_az                          = var.repl_instance_multi_az
  apply_immediately                 = var.repl_instance_apply_immediately
  auto_minor_version_upgrade        = var.repl_instance_auto_minor_version_upgrade
  allow_major_version_upgrade       = var.repl_instance_allow_major_version_upgrade
  preferred_maintenance_window      = var.repl_instance_preferred_maintenance_window
  tags                              = var.tags
}

resource "aws_dms_endpoint" "source" {
  endpoint_id                   = var.source_endpoint.endpoint_id
  endpoint_type                 = "source"
  engine_name                   = var.source_endpoint.engine_name
  username                      = var.source_endpoint.username
  password                      = var.source_endpoint.password
  server_name                   = var.source_endpoint.server_name
  port                          = var.source_endpoint.port
  database_name                 = var.source_endpoint.database_name
  ssl_mode                      = var.source_endpoint.ssl_mode
  extra_connection_attributes   = var.source_endpoint.extra_connection_attributes
  tags                          = var.source_endpoint.tags
}

resource "aws_dms_endpoint" "destination" {
  endpoint_id                   = var.destination_endpoint.endpoint_id
  endpoint_type                 = "target"
  engine_name                   = var.destination_endpoint.engine_name
  username                      = var.destination_endpoint.username
  password                      = var.destination_endpoint.password
  server_name                   = var.destination_endpoint.server_name
  port                          = var.destination_endpoint.port
  database_name                 = var.destination_endpoint.database_name
  ssl_mode                      = var.destination_endpoint.ssl_mode
  tags                          = var.destination_endpoint.tags
}

resource "aws_dms_replication_task" "this" {
  replication_task_id           = var.replication_task.replication_task_id
  migration_type                = var.replication_task.migration_type
  replication_instance_arn      = aws_dms_replication_instance.this.replication_instance_arn
  source_endpoint_arn           = aws_dms_endpoint.source.endpoint_arn
  target_endpoint_arn           = aws_dms_endpoint.destination.endpoint_arn
  replication_task_settings     = file(var.replication_task.replication_task_settings)
  table_mappings                = file(var.replication_task.table_mappings)
  tags                          = var.replication_task.tags
}

resource "aws_dms_event_subscription" "instance_events" {
  name             = var.event_subscriptions.instance.name
  sns_topic_arn    = var.event_subscriptions.instance.sns_topic_arn
  source_type      = var.event_subscriptions.instance.source_type
  source_ids       = [aws_dms_replication_instance.this.replication_instance_id]
  event_categories = var.event_subscriptions.instance.event_categories
  enabled          = var.event_subscriptions.instance.enabled
}

resource "aws_dms_event_subscription" "task_events" {
  name             = var.event_subscriptions.task.name
  sns_topic_arn    = var.event_subscriptions.task.sns_topic_arn
  source_type      = var.event_subscriptions.task.source_type
  source_ids       = [aws_dms_replication_task.this.replication_task_id]
  event_categories = var.event_subscriptions.task.event_categories
  enabled          = var.event_subscriptions.task.enabled
}
