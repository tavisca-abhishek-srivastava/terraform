provider "aws" {
region = "us-east-1"
}

resource "aws_security_group" "ec2_security_groups" {
    name   = var.name_security_groups
    vpc_id = var.vpc_id
}

resource "aws_security_group_rule" "ingress_rule_nginx" {
  count = length(var.sg_ingress_rules)
  type              = "ingress"
  from_port         = var.sg_ingress_rules[count.index].from_port
  to_port           = var.sg_ingress_rules[count.index].to_port
  protocol          = var.sg_ingress_rules[count.index].protocol
  cidr_blocks       = [var.sg_ingress_rules[count.index].cidr_block]
  description       = var.sg_ingress_rules[count.index].description
  security_group_id = aws_security_group.ec2_security_groups.id
}
resource "aws_security_group_rule" "egress_rule_nginx" {
  count = length(var.sg_egress_rules)
  type              = "egress"
  from_port         = var.sg_egress_rules[count.index].from_port
  to_port           = var.sg_egress_rules[count.index].to_port
  protocol          = var.sg_egress_rules[count.index].protocol
  cidr_blocks       = [var.sg_egress_rules[count.index].cidr_block]
  
  security_group_id = aws_security_group.ec2_security_groups.id
}