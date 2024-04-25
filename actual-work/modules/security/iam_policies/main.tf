module "iam_policy_document_example" {
  source           = "../iam_policy_document_for_role/"
  key_policy_statements = var.key_policy_statements
}

resource "aws_iam_policy" "policy_user_role" {
  name        = var.policy_name
  description = var.policy_description
  policy      = module.iam_policy_document_example.policy_document_json
  tags = var.tags
}
