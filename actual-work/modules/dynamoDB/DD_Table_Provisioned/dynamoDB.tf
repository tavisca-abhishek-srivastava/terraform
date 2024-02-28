#--------------------------------------------------------------------------------#
#                                                                                #
#                                                                                #
#--------------------------------------------------------------------------------#

resource "aws_dynamodb_table" "DD_Table_Provisioned" {
  name                        = var.aws_dynamodb_table_name
  table_class                 = var.table_class
  billing_mode                = "PROVISIONED"
  hash_key                    = var.table_hash_key
  range_key                   = var.table_range_key
  deletion_protection_enabled = var.enable_deletion_protection
  read_capacity               = var.table_read_capacity_unit
  write_capacity              = var.table_write_capacity_unit
  stream_enabled = var.is_stream_enabled
  stream_view_type = (var.is_stream_enabled == false ? null: var.stream_view_type)


  point_in_time_recovery {
    enabled = true
  }
  server_side_encryption {
    enabled     = true # true -> "Managed by customer" , false -> "Managed by DynamoDB "
    kms_key_arn = var.kms_key_arn
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
    AppName : "tf-nrt-${var.aws_dynamodb_table_name}"
    InfraOwner : "sre-cloud-reliability@tavisca.com"
    BusinessUnit : "travel.app"
    Backup : "no"
    Product : "poap"
    Name : "tf-${var.aws_dynamodb_table_name}"
  }

  # lifecycle {
  #   precondition {
  #     condition     = var.table_autoscaling_min_read_capacity_unit >= var.table_read_capacity_unit
  #     error_message = "table_autoscaling_min_read_capacity_unit is less than table_read_capacity_unit"
  #   }

  # }
}