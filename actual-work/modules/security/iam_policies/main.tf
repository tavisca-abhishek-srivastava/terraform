module "iam_policy_document_example" {
  source           = "../iam_policy_document/iam_identity_based_policy_document/"
  key_policy_statements = var.key_policy_statements
}

resource "aws_iam_policy" "user_role_policy" {
  name        = var.policy_name
  description = var.policy_description
  policy      = module.iam_policy_document_example.policy_document_json
  tags = var.tags
}