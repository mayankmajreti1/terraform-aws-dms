variable "repl_subnet_group_name" {}
variable "repl_subnet_group_description" {}
variable "repl_subnet_group_subnet_ids" {
  type = list(string)
}

variable "repl_instance_id" {}
variable "repl_instance_class" {}
variable "repl_instance_allocated_storage" {}
variable "repl_instance_engine_version" {}
variable "repl_instance_vpc_security_group_ids" {
  type = list(string)
}
variable "repl_instance_publicly_accessible" {}
variable "repl_instance_multi_az" {}
variable "repl_instance_apply_immediately" {}
variable "repl_instance_auto_minor_version_upgrade" {}
variable "repl_instance_allow_major_version_upgrade" {}
variable "repl_instance_preferred_maintenance_window" {}

variable "tags" {
  type = map(string)
}

variable "source_endpoint" {
  type = object({
    endpoint_id                 = string
    engine_name                 = string
    username                    = string
    password                    = string
    server_name                 = string
    port                        = number
    database_name               = string
    ssl_mode                    = string
    extra_connection_attributes = optional(string)
    tags                        = map(string)
  })
}

variable "destination_endpoint" {
  type = object({
    endpoint_id     = string
    engine_name     = string
    username        = string
    password        = string
    server_name     = string
    port            = number
    database_name   = string
    ssl_mode        = string
    tags            = map(string)
  })
}

variable "replication_task" {
  type = object({
    replication_task_id       = string
    migration_type            = string
    replication_task_settings = string
    table_mappings            = string
    tags                      = map(string)
  })
}

variable "event_subscriptions" {
  type = object({
    instance = object({
      name               = string
      enabled            = bool
      sns_topic_arn      = string
      source_type        = string
      event_categories   = list(string)
    })
    task = object({
      name               = string
      enabled            = bool
      sns_topic_arn      = string
      source_type        = string
      event_categories   = list(string)
    })
  })
}
