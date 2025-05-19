resource "aws_security_group" "dms_sg" {
  name        = "${local.service_name_prefix}-dms-sg"
  description = "dms security group"
  vpc_id      = var.vpc_id
  tags = merge(local.common_tags, tomap({
    "Name" : local.project_name_prefix
    })
  )

  ingress {
    from_port   = var.from_port
    to_port     = var.to_port
    protocol    = "tcp"
    cidr_blocks = var.cidr_blocks
  }
}