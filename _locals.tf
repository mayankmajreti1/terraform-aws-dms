locals {
  replication_task_settings = jsondecode(file(var.replication_task.replication_task_settings))
  table_mappings            = jsondecode(file(var.replication_task.table_mappings))

  service_name_prefix = var.name == "" ? terraform.workspace : var.name
  project_name_prefix = var.name == "" ? terraform.workspace : var.name
  account_name_prefix = var.name == "" ? terraform.workspace : var.name
  common_tags         = length(var.common_tags) == 0 ? var.default_tags : merge(var.default_tags, var.common_tags)
}