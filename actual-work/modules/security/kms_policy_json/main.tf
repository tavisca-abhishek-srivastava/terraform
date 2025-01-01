resource "aws_kms_key" "encryption_key" {
  
    key_usage                = "ENCRYPT_DECRYPT"
    description              = var.key_description
    deletion_window_in_days  = var.delete_after_days
    customer_master_key_spec = "SYMMETRIC_DEFAULT"
    enable_key_rotation      = true
    multi_region             = true 
    tags = var.kms_tags
    provider = aws.instancemaker
    
}


resource "aws_kms_key_policy" "key_policy" {
  
    key_id =  aws_kms_key.encryption_key[1].key_id
    policy =  jsonencode(var.key_policy_map)
    provider = aws.instancemaker
}
resource "aws_kms_alias" "key_alias" {
#   name          = "alias/nrt_encryption_key"

    name = var.kms_alias
    target_key_id = aws_kms_key.encryption_key[1].key_id
    provider = aws.instancemaker
}


