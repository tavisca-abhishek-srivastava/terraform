module "nrt-dynamoDB" {
    source = "../../../../modules/database/dynamoDB/dd_table_provisioned"
    table_hash_key = var.table_hash_key
    table_name = var.table_name
    table_class = var.table_class
    enable_deletion_protection = var.enable_deletion_protection
    table_read_capacity_unit = var.table_read_capacity_unit
    table_write_capacity_unit = var.table_write_capacity_unit
    table_autoscaling_min_read_capacity_unit = var.table_autoscaling_min_read_capacity_unit
    table_autoscaling_max_read_capacity_unit = var.table_autoscaling_max_read_capacity_unit
    table_read_target_percent = var.table_read_target_percent
    table_write_target_percent = var.table_write_target_percent
    table_range_key = var.table_range_key
    table_autoscaling_min_write_capacity_unit = var.table_autoscaling_min_write_capacity_unit
    table_autoscaling_max_write_capacity_unit = var.table_autoscaling_max_write_capacity_unit
    attributes = var.attributes
    gsi_indices = var.gsi_indices
    lsi_indices = var.lsi_indices
    ttl_enabled = var.ttl_enabled
    attribute_for_ttl = var.attribute_for_ttl
    kms_alias = var.kms_alias
    key_policy_map = var.key_policy_map
    key_description = var.key_description
    delete_after_days = var.delete_after_days
    encryption_key_details = var.encryption_key_details
    is_data_imported = var.is_data_imported
    bucket_name_to_import_data = var.bucket_name_to_import_data
    import_data_key_prefix = var.import_data_key_prefix
    is_stream_enabled = var.is_stream_enabled
    stream_view_type = var.stream_view_type
    terrform_operation_timeout = var.terrform_operation_timeout
    

    
}