resource "aws_dynamodb_table" "ddtable_plain" {
  name = "${var.aws_dynamodb_table_name}"
  billing_mode   = "PROVISIONED"
  read_capacity  = 30
  write_capacity = 30
  hash_key = var.hash_key
  range_key = var.range_key
  
   dynamic "global_secondary_index" {
   for_each = local.gsi_indices
    content {
      name            = global_secondary_index.key
      write_capacity  = global_secondary_index.value.write_capacity
      read_capacity   = global_secondary_index.value.read_capacity
      range_key       = global_secondary_index.value.range_key
      hash_key        = global_secondary_index.key
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