module "nrt-dax" {
    source = "../../modules/dynamoDB/DD_DAX"
    security_group_ids = var.security_group_ids
    cluster_description = var.cluster_description
    replication_factor = var.replication_factor
    cluster_name = var.cluster_name
    iam_role_arn = var.iam_role_arn
    node_type = var.node_type
    aws_dax_parameter_group_name = var.aws_dax_parameter_group_name
    aws_dax_parameter_group_description = var.aws_dax_parameter_group_description
    subnet_group_details = var.subnet_group_details
    query_ttl_millis = var.query_ttl_millis
    record_ttl_millis = var.record_ttl_millis
    tags = var.tags




    
}