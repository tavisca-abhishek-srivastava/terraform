module "nrt-dynamoDB" {
    source = "../../modules/dynamoDB"
    table_hash_key = "ABC"   
}