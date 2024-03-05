resource "aws_kms_key" "dynamodb_encryption_key" {
for_each = (var.need_cmk == false ? [] : [1])
  key_usage                = "ENCRYPT_DECRYPT"
  description              = var.key_description
  deletion_window_in_days  = var.delete_after_days
  customer_master_key_spec = "SYMMETRIC_DEFAULT"
  enable_key_rotation      = true
  multi_region             = true
  tags = {
    DataClassification : "restricted"
    Environment : "poc"
    AppName : "tf-nrt-kms-app"
    InfraOwner : "sre-cloud-reliability@tavisca.com"
    BusinessUnit : "travel.app"
    Backup : "no"
    Product : "poap"
    Name : "tf-nrt-kms"
  }
}

resource "aws_kms_key_policy" "dd_table_key_policy" {
for_each = (var.need_cmk ==  false ? [] : [1] )
  key_id = aws_kms_key.dynamodb_encryption_key.key_id
  policy = jsonencode(var.key_policy_map)


}
resource "aws_kms_alias" "key_alias" {
for_each = (var.need_cmk ==  false ? [] : [1] )
#   name          = "alias/nrt_encryption_key"
    name = var.kms_alias
    target_key_id = aws_kms_key.dynamodb_encryption_key.key_id
}