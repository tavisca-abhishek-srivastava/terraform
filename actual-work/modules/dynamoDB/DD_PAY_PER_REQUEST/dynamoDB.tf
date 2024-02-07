

resource "aws_dynamodb_table" "ddtable_DD_PAY_PER_REQUEST" {
  name = "${var.aws_dynamodb_table_name}"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key = var.table_hash_key
  range_key = var.range_key
  server_side_encryption {
    enabled = true
    kms_key_arn = "arn:aws:kms:us-east-1:928814396842:key/bb8d50d3-6d96-4b26-8e3e-eb9e3026be18"
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
    range_key = local_secondary_index.range_key
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
