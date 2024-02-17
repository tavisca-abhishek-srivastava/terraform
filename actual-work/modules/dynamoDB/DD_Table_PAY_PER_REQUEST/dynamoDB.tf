
#--------------------------------------------------------------------------------#
#                                                                                #
#                                                                                #
#--------------------------------------------------------------------------------#

resource "aws_dynamodb_table" "ddtable_DD_PROVISIONED" {
  name = "${var.aws_dynamodb_table_name}"
  billing_mode   = "PROVISIONED"
  read_capacity = 10
  write_capacity = 10
  hash_key = var.table_hash_key
  range_key = var.table_range_key
  deletion_protection_enabled = var.enable_deletion_protection
  point_in_time_recovery {
    enabled = true
  }
  server_side_encryption {
    enabled = true   # true -> "Managed by customer" , false -> "Managed by DynamoDB "
    kms_key_arn = var.kms_key_arn
  }
  
   dynamic "global_secondary_index" {
   for_each = var.gsi_indices
    content {
      name            = global_secondary_index.key
      write_capacity  = global_secondary_index.value.write_capacity
      read_capacity   = global_secondary_index.value.read_capacity
      range_key       = global_secondary_index.value.range_key
      hash_key        = global_secondary_index.key
      projection_type = "ALL"
    }
  }
  dynamic "local_secondary_index" {
    for_each = var.lsi_indices
    content {
    name = local_secondary_index.key
    range_key = local_secondary_index.value.range_key
    projection_type = "ALL"
  }
  }
   dynamic "attribute" {
    for_each = var.attributes
    content {
      name = attribute.value.name
      type = attribute.value.type
    }
   }

  tags =   {
    DataClassification : "restricted"
    Environment : "poc"
    AppName : "tf-nrt-${var.aws_dynamodb_table_name}"
    InfraOwner : "sre-cloud-reliability@tavisca.com"
    BusinessUnit : "travel.app"
    Backup : "no"
    Product : "poap"
    Name : "tf-${var.aws_dynamodb_table_name}"
  }
}