resource "aws_kms_key" "dynamodb_encryption_key" {
    key_usage = "ENCRYPT_DECRYPT"
    description = "key_for_dynamoDB"
    deletion_window_in_days = 10
    customer_master_key_spec = "SYMMETRIC_DEFAULT"
    enable_key_rotation = true
    multi_region = true
}
resource "aws_kms_grant" "a" {
  name              = "my-grant"
  key_id            = aws_kms_key.dynamodb_encryption_key.key_id
  grantee_principal = "arn:aws:iam::928814396842:user/cloud-dr-user"
  operations        = ["Encrypt", "Decrypt", "GenerateDataKey"]
  }