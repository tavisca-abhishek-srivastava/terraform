module "policy1" {
    source           = "../../../modules/security/iam_policies"
    policy_name   = var.policy_name
    policy_description = var.policy_description
    key_policy_statements = var.key_policy_statements
    tags = var.tags
}