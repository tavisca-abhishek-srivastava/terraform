#--------------------------------------------------------------------------------#
#                                                                                #
#                                                                                #
#--------------------------------------------------------------------------------#

# This module will take user input and will create CMK which will be used by DynamoDB module

module "dd_cmk" {
  source            = "../../KMS"
  kms_alias         = var.kms_alias
  delete_after_days = var.delete_after_days
  key_description   = var.key_description
  key_policy_map    = var.key_policy_map
  # need_cmk = (var.encryption_key_details.key_type == "customer_managed" ? true : false)
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

  ttl {
    enabled        = var.ttl_enabled
    attribute_name = var.attribute_for_ttl
  }
  stream_enabled   = var.is_stream_enabled
  stream_view_type = (var.is_stream_enabled == false ? null : var.stream_view_type)

  point_in_time_recovery {
    enabled = true
  }
  server_side_encryption {
    enabled = (var.encryption_key_details.key_type == "dynamoDB_managed" ? false : true)
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
      name            = "${local_secondary_index.key}_LSI"
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

dynamic "import_table" {
    for_each = (var.is_data_imported == false ? [] : [1])
    content {
      input_format           = "DYNAMODB_JSON"
      input_compression_type = "GZIP"
      s3_bucket_source {
        bucket     = var.bucket_name_to_import_data #"dynamodb-export-bnr"
        key_prefix = var.import_data_key_prefix   #"AWSDynamoDB/01709454326412-6fb4bf52/data/l2anfo7m6a2l5mcehw23bceolm.json.gz"
      }
    }
  }

lifecycle {
  ignore_changes = [ read_capacity,write_capacity,import_table,local_secondary_index ]
}

timeouts {
  create = "360m"  
}

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