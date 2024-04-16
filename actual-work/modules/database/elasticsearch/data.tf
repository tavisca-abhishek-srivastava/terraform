data "aws_iam_policy_document" "opensearch_access_policy" {
  statement {
    effect = "Allow"

    principals {
      type        = "*"
      identifiers = ["*"]
    }

    actions = ["es:*"]

    resources = ["arn:aws:es:${var.aws_region}:${data.aws_caller_identity.current.account_id}:domain/${var.elastic_search_domain_name}/*"]
  }
}



