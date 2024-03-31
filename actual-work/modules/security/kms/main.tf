

resource "aws_kms_key" "dynamodb_encryption_key" {
  key_usage                = "ENCRYPT_DECRYPT"
  description              = var.key_description
  deletion_window_in_days  = var.delete_after_days
  customer_master_key_spec = "SYMMETRIC_DEFAULT"
  enable_key_rotation      = true
  multi_region             = true 
  tags = var.kms_tags
}

resource "aws_kms_key_policy" "dd_table_key_policy" {
  key_id = aws_kms_key.dynamodb_encryption_key.key_id
  policy = jsonencode(var.key_policy_map)
}
resource "aws_kms_alias" "key_alias" {
#   name          = "alias/nrt_encryption_key"
    name = var.kms_alias
    target_key_id = aws_kms_key.dynamodb_encryption_key.key_id
}

# setting for replica cmk in another region
resource "aws_kms_replica_key" "replica" {
  provider = aws.replica

  description             = var.key_description
  deletion_window_in_days = var.delete_after_days
  primary_key_arn         = aws_kms_key.dynamodb_encryption_key.arn
  policy                  = var.replica_key_policy

  tags = var.kms_tags
}
# Add an alias to the replica key
resource "aws_kms_alias" "replica" {
  provider = aws.replica

  name          = var.kms_alias
  target_key_id = aws_kms_replica_key.replica.key_id
}
