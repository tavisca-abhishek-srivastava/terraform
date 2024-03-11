resource "aws_dax_parameter_group" "new_cluster_paraameter_group" {
  name        = var.aws_dax_parameter_group_name
  description = var.aws_dax_parameter_group_description

  parameters {
    name  = "query-ttl-millis"
    value = var.query_ttl_millis
  }

  parameters {
    name  = "record-ttl-millis"
    value = var.record_ttl_millis
  }
}

resource "aws_dax_cluster" "new_dax_cluster" {
  cluster_name                     = var.cluster_name
  description                      = var.cluster_description
  iam_role_arn                     = var.iam_role_arn
  node_type                        = var.node_type
  cluster_endpoint_encryption_type = var.cluster_endpoint_encryption_type
  replication_factor               = var.replication_factor
  parameter_group_name             = aws_dax_parameter_group.new_cluster_paraameter_group.id
  subnet_group_name                = aws_dax_subnet_group.dax_subnet_group.id
  server_side_encryption {
    enabled = true
  }
  tags = var.tags

}