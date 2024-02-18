module "nrt-dynamoDB" {
    source = "../../modules/dynamoDB/DD_Table_Provisioned"
    table_hash_key = var.table_hash_key
}