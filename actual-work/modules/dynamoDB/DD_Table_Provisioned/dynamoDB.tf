#--------------------------------------------------------------------------------#
#                                                                                #
#                                                                                #
#--------------------------------------------------------------------------------#

# This module will take user input and will create CMK which will be used by DynamoDB module

module "dd_cmk" {
  source = "../../KMS"
  kms_alias = "alias/nrt_encryption_key"
  delete_after_days = var.delete_after_days
  description = var.description
  key_policy_map = var.key_policy_map
}

# This module is for DynamoDB

resource "aws_dynamodb_table" "dd_table_provisioned" {
  name                        = var.table_name
  table_class                 = var.table_class
  billing_mode                = "PROVISIONED"
  hash_key                    = var.table_hash_key
  range_key                   = var.table_range_key
  deletion_protection_enabled = var.enable_deletion_protection
  read_capacity               = var.table_read_capacity_unit
  write_capacity              = var.table_write_capacity_unit
  dynamic "ttl" {
    for_each = (var.ttl_enabled == false ? []: [1])
    content {
      enabled = var.ttl_enabled
      attribute_name = (var.ttl_enabled == false ? null: var.attribute_for_ttl)
    }
    
  }
  stream_enabled = var.is_stream_enabled
  stream_view_type = (var.is_stream_enabled == false ? null: var.stream_view_type)


  point_in_time_recovery {
    enabled = true
  }
  server_side_encryption {
    enabled     = true # true -> "Managed by customer" , false -> "Managed by DynamoDB "
    kms_key_arn = module.dd_cmk.mrk_cms_arn
  }
  # runtime Generation of GSIs from user input

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
  # runtime Generation of LSI from user input

  dynamic "local_secondary_index" {
    for_each = var.lsi_indices
    content {
      name            = local_secondary_index.key
      range_key       = local_secondary_index.value.range_key
      projection_type = "ALL"
    }
  }
  # runtime defenition of Table attribute from user input

  dynamic "attribute" {
    for_each = var.attributes
    content {
      name = attribute.value.name
      type = attribute.value.type
    }
  }
  # tags = var.fixed_tags 

  tags = {
    DataClassification : "restricted"
    Environment : "poc"
    AppName : "tf-nrt-${var.table_name}"
    InfraOwner : "sre-cloud-reliability@tavisca.com"
    BusinessUnit : "travel.app"
    Backup : "no"
    Product : "poap"
    Name : "tf-${var.table_name}"
  }

}