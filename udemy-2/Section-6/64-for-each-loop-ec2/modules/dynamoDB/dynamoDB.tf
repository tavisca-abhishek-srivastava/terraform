resource "aws_dynamodb_table" "ddtable_plain" {
  name = "${var.aws_dynamodb_table_name}"
  billing_mode   = "PROVISIONED"
  read_capacity  = 30
  write_capacity = 30
  hash_key = var.hash_key
  range_key = var.range_key
  
#     global_secondary_index {
#         name               = "product_id-user_id-index"
#         hash_key           = "product_id"
#         range_key          = "user_id"
#         write_capacity     = 10
#         read_capacity      = 10
#         projection_type    = "ALL"
        
#   }

    for_each = var.other_attr
        attribute {
        name = each.value.name
        type = each.value.type
        }
    # attribute {
    #   name = "user_id"
    #   type = "S"
    # }
    # attribute {
    #   name = "product_id"
    #   type = "S"
    # }
    



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