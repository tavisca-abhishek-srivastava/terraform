provider "aws" {
  alias  = "replica"
  region = var.replica_region
}

resource "aws_kms_key" "encryption_key" {
  key_usage                = "ENCRYPT_DECRYPT"
  description              = var.key_description
  deletion_window_in_days  = var.delete_after_days
  customer_master_key_spec = "SYMMETRIC_DEFAULT"
  enable_key_rotation      = true
  multi_region             = true 
  tags = var.tags
}

data "aws_iam_policy_document" "kms_policy" {

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


resource "aws_kms_key_policy" "key_policy" {
  key_id = aws_kms_key.encryption_key.key_id
  policy = data.aws_iam_policy_document.kms_policy.json   ###jsonencode(var.key_policy_map)
}
resource "aws_kms_alias" "key_alias" {
#   name          = "alias/nrt_encryption_key"
    name = var.kms_alias
    target_key_id = aws_kms_key.encryption_key.key_id
}

# setting for replica cmk in another region
data "aws_iam_policy_document" "replica_kms_policy" {
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

resource "aws_kms_replica_key" "replica" {
  for_each = var.need_kms_replica == true ? toset(["1"]):toset([])
  provider = aws.replica
  description             = var.key_description
  deletion_window_in_days = var.delete_after_days
  primary_key_arn         = aws_kms_key.encryption_key.arn
  policy                  =  data.aws_iam_policy_document.replica_kms_policy.json                           ###jsonencode(var.replica_key_policy)

  tags = var.tags
}
##### Add an alias to the replica key
resource "aws_kms_alias" "replica" {
  for_each = var.need_kms_replica == true ? toset(["1"]):toset([])
  provider = aws.replica
  name          = var.kms_alias
  target_key_id = aws_kms_replica_key.replica[1].key_id
}
