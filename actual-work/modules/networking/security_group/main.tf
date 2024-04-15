
resource "aws_security_group" "security_group" {
  name        = var.name
  description = var.description
  vpc_id      = var.vpc_id

  dynamic "ingress" {
    for_each = var.ingress_rules

    content {
      from_port       = ingress.value.from_port
      to_port         = ingress.value.to_port
      protocol        = ingress.value.protocol
      cidr_blocks     = ingress.value.cidr_blocks
      security_groups = ingress.value.source_sg_id != "" ? [ingress.value.source_sg_id] : []
      self            = ingress.value.self_referencing
    }
  }

  dynamic "egress" {
    for_each = var.egress_rules

    content {
      from_port       = egress.value.from_port
      to_port         = egress.value.to_port
      protocol        = egress.value.protocol
      cidr_blocks     = egress.value.cidr_blocks
      security_groups = egress.value.source_sg_id != "" ? [egress.value.source_sg_id] : []
      self            = egress.value.self_referencing
    }
  }
}
