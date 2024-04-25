module "iam_policy_document_example" {
    source           = "../../../modules/security/iam_policy_document"
    key_policy_statements = var.key_policy_statements
}



module "policy1" {
    source           = "../../../modules/security/iam_policies"
    policy_name   = var.policy_name
    policy_description = var.policy_description
    policy_document = module.iam_policy_document_example.policy_document_json  #### took json as input from "iam_policy_document" imported above
    tags = var.tags
}