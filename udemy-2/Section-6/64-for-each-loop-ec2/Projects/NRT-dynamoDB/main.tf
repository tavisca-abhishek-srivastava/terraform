module "nrt-dynamoDB" {
    source = "../../modules/dynamoDB"
    table_hash_key = var.table_hash_key
}