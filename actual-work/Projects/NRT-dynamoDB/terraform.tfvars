table_hash_key = "user_id"
table_range_key = "product_id"
table_name = "DynamoDB-GSI-LSI"
table_class = "STANDARD_INFREQUENT_ACCESS"
enable_deletion_protection = false
table_read_capacity_unit = 90
table_write_capacity_unit = 50
table_autoscaling_min_read_capacity_unit = 900
table_autoscaling_max_read_capacity_unit = 3000
table_read_target_percent = 80
table_write_target_percent = 80
table_autoscaling_max_write_capacity_unit = 3000
table_autoscaling_min_write_capacity_unit = 500
ttl_enabled = false
attribute_for_ttl = "otpttl"
attributes = {
    "attr1" = { name = "user_id", type = "S" },
    "attr2" = { name = "product_id", type = "S" },
    "attr3" = { name = "product_name", type = "S" },
    "attr4" = { name = "product_desc", type = "S" },
    "attr5" = { name = "age", type = "N" },
  }
gsi_indices = {
    # in key-value pair, key will be GSI hash_key
    "product_name" = { write_capacity = 60, read_capacity = 60, range_key = "product_id" },
    "product_desc" = { write_capacity = 60, read_capacity = 60, range_key = "product_id" },
    "age"          = { write_capacity = 65, read_capacity = 65, range_key = "user_id" },
    "product_id" = { write_capacity = 60, read_capacity = 60, range_key = "user_id" },
  }
  lsi_indices = { 
   "by_age" = {range_key = "age"},
  }
  