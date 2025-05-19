output "replication_instance_arn" {
  value = aws_dms_replication_instance.this.replication_instance_arn
}

output "replication_task_id" {
  value = aws_dms_replication_task.this.replication_task_id
}

output "source_endpoint_arn" {
  value = aws_dms_endpoint.source.endpoint_arn
}

output "destination_endpoint_arn" {
  value = aws_dms_endpoint.destination.endpoint_arn
}
