output "mrk_cms_arn" {
  value = aws_kms_key.dynamodb_encryption_key[count.index].arn
}