table_hash_key = "user_id"
table_range_key = "product_id"
aws_dynamodb_table_name = "tf_bnr_testing_provisioned"
table_class = "STANDARD_INFREQUENT_ACCESS"
enable_deletion_protection = false
table_read_capacity_unit = 90
table_write_capacity_unit = 50
table_autoscaling_min_read_capacity_unit = 90
table_autoscaling_max_read_capacity_unit = 300
table_read_target_percent = 80
table_write_target_percent = 80


