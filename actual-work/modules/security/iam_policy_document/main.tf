data "aws_iam_policy_document" "policy_document" {
  dynamic "statement" {
    for_each = var.key_policy_statements
    content {
      sid = statement.value.sid
      actions = statement.value.actions
      resources = statement.value.resources
      effect = statement.value.effect
      dynamic "principals" {
        for_each = statement.value.principals
        content {
          type = "AWS"
          identifiers = principals.value
        }
      }
    }
  }
}