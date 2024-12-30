module "security_group" {
  for_each = var.sg_configs
  source        = "cxloyaltyjfrogus.jfrog.io/poap2-terraform-poc-virtual__networking/security-group/aws"
  version       = "1.0.1"
  vpc_id        = each.value.vpc_id
  name          = each.value.name
  description = each.value.description
  ingress_rules = each.value.ingress_rules
  egress_rules  = each.value.egress_rules
}
