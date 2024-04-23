module "nrt-dax" {
    source = "../../../modules/dynamodb/dd_dax"
    cluster_name = var.cluster_name
    cluster_description = var.cluster_description
    replication_factor = var.replication_factor
    security_group_ids = var.security_group_ids
    iam_role_arn = var.iam_role_arn
    node_type = var.node_type
    aws_dax_parameter_group_name = var.aws_dax_parameter_group_name
    aws_dax_parameter_group_description = var.aws_dax_parameter_group_description
    subnet_group_details = var.subnet_group_details
    query_ttl_millis = var.query_ttl_millis
    record_ttl_millis = var.record_ttl_millis
    tags = var.tags
}