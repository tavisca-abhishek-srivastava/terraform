module "nrt-dynamoDB" {
    source = "../../modules/dynamoDB/DD_Table_Provisioned"
    table_hash_key = var.table_hash_key
    aws_dynamodb_table_name = var.aws_dynamodb_table_name
    table_class = var.table_class
    enable_deletion_protection = var.enable_deletion_protection
}