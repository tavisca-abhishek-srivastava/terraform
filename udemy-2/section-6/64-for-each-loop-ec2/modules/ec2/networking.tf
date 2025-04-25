resource "aws_security_group" "ec2_security_groups_for_each" {
  name   = var.name_security_groups
  vpc_id = var.vpc_id
}

resource "aws_security_group_rule" "ingress_rule_module" {
  type              = "ingress"
  for_each          = var.sg_ingress_rules
  from_port         = each.value.from_port
  to_port           = each.value.to_port
  protocol          = each.value.protocol
  cidr_blocks       = [each.value.cidr_block]
  description       = each.value.description
  security_group_id = aws_security_group.ec2_security_groups_for_each.id
}
resource "aws_security_group_rule" "egress_rule_module" {
  type        = "egress"
  for_each    = var.sg_egress_rules
  from_port   = each.value.from_port
  to_port     = each.value.to_port
  protocol    = each.value.protocol
  cidr_blocks = [each.value.cidr_block]

  security_group_id = aws_security_group.ec2_security_groups_for_each.id
}