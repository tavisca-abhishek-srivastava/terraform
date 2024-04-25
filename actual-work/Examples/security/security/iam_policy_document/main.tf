module "iam_policy_document_example" {
    source           = "../../../modules/security/iam_policy_document"
    key_policy_statements = var.key_policy_statements
}



module "policy1" {
    source           = "../../../modules/security/iam_policies"
    policy_name   = "iac-test-policy"
    policy_description = "This is a test policy for IAC"
    policy_document = module.iam_policy_document_example.policy_document_json  #### took json as input from "iam_policy_document" imported above
}