resource "aws_kms_key" "encryption_key" {
  for_each = var.is_this_primary == true ? toset(["1"]):toset([])
    key_usage                = "ENCRYPT_DECRYPT"
    description              = var.key_description
    deletion_window_in_days  = var.deletion_window_in_days
    customer_master_key_spec = "SYMMETRIC_DEFAULT"
    enable_key_rotation      = true
    multi_region             = true 
    tags = var.tags
    provider = aws.primary
    
}



resource "aws_kms_key_policy" "key_policy" {
  for_each =  var.is_this_primary == true ? toset(["1"]):toset([])
    key_id =  aws_kms_key.encryption_key[1].key_id
    policy =  jsonencode(var.key_policy_map)   ###jsonencode(var.key_policy_map)
    provider = aws.primary
}
resource "aws_kms_alias" "key_alias" {
#   name          = "alias/nrt_encryption_key"
for_each = var.is_this_primary == true ? toset(["1"]):toset([])
    name = var.kms_alias
    target_key_id = aws_kms_key.encryption_key[1].key_id
    provider = aws.primary
}


########## setting for replica cmk in another region   #####################

resource "aws_kms_replica_key" "replica" {
  for_each = (var.need_kms_replica == true && var.is_kms_replica == true ) ? toset(["1"]):toset([])
  description             =   var.key_description
  deletion_window_in_days =   var.deletion_window_in_days
  primary_key_arn         =   var.primary_key_arn  ##aws_kms_key.encryption_key.arn
  policy                  =   jsonencode(var.key_policy_map)
  tags = var.tags
  provider = aws.replica
}
resource "aws_kms_key_policy" "replica_key_policy" {
    key_id =  aws_kms_replica_key.replica[1].key_id
    policy =  jsonencode(var.key_policy_map)
    provider = aws.replica
}
################## Add an alias to the replica key    #######################

resource "aws_kms_alias" "replica" {
  for_each = (var.need_kms_replica == true && var.is_kms_replica == true ) ? toset(["1"]):toset([])
  # provider = aws.replica
  name          = var.kms_alias
  target_key_id = aws_kms_replica_key.replica[1].key_id
  provider = aws.replica
}