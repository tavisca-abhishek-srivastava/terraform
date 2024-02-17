module "nrt-dynamoDB" {
    source = "../../modules/dynamoDB/DD_Table_PAY_PER_REQUEST"
    table_hash_key = var.table_hash_key
}