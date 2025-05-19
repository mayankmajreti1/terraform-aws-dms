variable "name" {
  type        = string
  description = "A string value to describe prefix of all the resources"
  default     = "non-prod-generic"
}

variable "common_tags" {
  type        = map(string)
  description = "A map to add common tags to all the resources"
  default = {
    "Project"     = "Internal"
    "Environment" = "Dev"
    "ManagedBy"   = "Terraform"
  }
}

variable "default_tags" {
  type        = map(string)
  description = "A map to add common tags to all the resources"
  default = {
    "Scope" : "DMS"
    "CreatedBy" : "Terraform"
  }
}

# VPC and Networking
variable "vpc_id" {
  description = "The VPC ID where DMS will be deployed"
  type        = string
  default     = "vpc-0312fdce447d35d09"
}

variable "private_subnet_ids" {
  description = "List of private subnet IDs for DMS"
  type        = list(string)
  default     = ["subnet-0f00ff9c7b685dcca", "subnet-082060390bd084408"]
}

variable "from_port" {
  description = "security groups from port"
  type        = number
  default     = 61616
}

variable "to_port" {
  description = "security groups to port"
  type        = number
  default     = 61616
}

variable "cidr_blocks" {
  type        = list(string)
  description = "A list of CIDR block ID's to allow access"
  default     = ["10.0.0.0/16"]
}

# DMS Subnet Group
variable "repl_subnet_group_name" {
  description = "The name for the replication subnet group"
  type        = string
  default     = "dms-subnet"
}

variable "repl_subnet_group_description" {
  description = "The description for the replication subnet group"
  type        = string
  default     = "DMS Subnet group"
}

# DMS Instance
variable "repl_instance_allocated_storage" {
  description = "The allocated storage in gigabytes"
  type        = number
  default     = 64
}

variable "repl_instance_auto_minor_version_upgrade" {
  description = "Whether minor engine upgrades will be applied automatically"
  type        = bool
  default     = true
}

variable "repl_instance_allow_major_version_upgrade" {
  description = "Whether major version upgrades are allowed"
  type        = bool
  default     = true
}

variable "repl_instance_apply_immediately" {
  description = "Whether to apply changes immediately"
  type        = bool
  default     = true
}

variable "repl_instance_engine_version" {
  description = "The engine version number"
  type        = string
  default     = "3.5.4"
}

variable "repl_instance_multi_az" {
  description = "Whether the instance should be multi-AZ"
  type        = bool
  default     = true
}

variable "repl_instance_preferred_maintenance_window" {
  description = "The weekly time range during which maintenance is performed"
  type        = string
  default     = "sun:10:30-sun:14:30"
}

variable "repl_instance_publicly_accessible" {
  description = "Whether the instance is publicly accessible"
  type        = bool
  default     = false
}

variable "repl_instance_class" {
  description = "The compute and memory capacity of the instance"
  type        = string
  default     = "dms.t3.medium"
}

variable "repl_instance_id" {
  description = "The identifier for the replication instance"
  type        = string
  default     = "test-instance-id"
}

# Endpoints
variable "source_endpoint" {
  description = "Configuration for the source endpoint"
  type = object({
    database_name = string
    endpoint_id   = string
    endpoint_type = string
    engine_name   = string
    username      = string
    password      = string
    port          = number
    server_name   = string
    ssl_mode      = string
    tags          = map(string)
  })
  default = {
    database_name = "testdb"
    endpoint_id   = "example-source"
    endpoint_type = "source"
    engine_name   = "aurora-postgresql"
    username      = "postgresqlUser"
    password      = "youShouldPickABetterPassword123!"
    port          = 5432
    server_name   = "dms-ex-src.cluster-abcdefghijk.us-east-1.rds.amazonaws.com"
    ssl_mode      = "none"
    tags          = { EndpointType = "source" }
  }
}

variable "destination_endpoint" {
  description = "Configuration for the destination endpoint"
  type = object({
    database_name = string
    endpoint_id   = string
    endpoint_type = string
    engine_name   = string
    username      = string
    password      = string
    port          = number
    server_name   = string
    ssl_mode      = string
    tags          = map(string)
  })
  default = {
    database_name = "testdb"
    endpoint_id   = "example-destination"
    endpoint_type = "target"
    engine_name   = "aurora"
    username      = "mysqlUser"
    password      = "passwordsDoNotNeedToMatch789?"
    port          = 3306
    server_name   = "dms-ex-dest.cluster-abcdefghijkl.us-east-1.rds.amazonaws.com"
    ssl_mode      = "none"
    tags          = { EndpointType = "destination" }
  }
}

# Replication Task
variable "replication_task" {
  description = "Configuration for the replication task"
  type = object({
    replication_task_id       = string
    migration_type            = string
    replication_task_settings = string
    table_mappings            = string
    source_endpoint_key       = string
    target_endpoint_key       = string
    tags                      = map(string)
  })
  default = {
    replication_task_id       = "example-cdc"
    migration_type            = "cdc"
    replication_task_settings = "./task_settings.json"
    table_mappings            = "./table_mappings.json"
    source_endpoint_key       = "source"
    target_endpoint_key       = "destination"
    tags                      = { Task = "PostgreSQL-to-MySQL" }
  }
}

# Event Subscriptions
variable "event_subscriptions" {
  description = "Configuration for event subscriptions"
  type = map(object({
    name                             = string
    enabled                          = bool
    source_type                      = string
    sns_topic_arn                    = string
    event_categories                 = list(string)
    instance_event_subscription_keys = optional(list(string))
    task_event_subscription_keys     = optional(list(string))
  }))
  default = {
    instance = {
      name                             = "instance-events"
      enabled                          = true
      instance_event_subscription_keys = ["example"]
      source_type                      = "replication-instance"
      sns_topic_arn                    = "arn:aws:sns:us-east-1:001861987316:dms-test-sns"
      event_categories                 = ["failure", "creation", "deletion", "maintenance", "failover", "low storage", "configuration change"]
    },
    task = {
      name                         = "task-events"
      enabled                      = true
      task_event_subscription_keys = ["cdc_ex"]
      source_type                  = "replication-task"
      sns_topic_arn                = "arn:aws:sns:us-east-1:001861987316:dms-test-sns"
      event_categories             = ["failure", "state change", "creation", "deletion", "configuration change"]
    }
  }
}