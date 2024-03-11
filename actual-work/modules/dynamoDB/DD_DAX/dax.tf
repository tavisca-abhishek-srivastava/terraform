resource "aws_db_subnet_group" "dax_subnet_group" {
  name = var.subnet_group_details.value.name
  subnet_ids = [subnet_group_details.value.subnet_id_1,subnet_group_details.value.subnet_id_2,subnet_group_details.value.subnet_id_3]
}

resource "aws_dax_cluster" "bar" {
    cluster_name       = var.cluster_name
    description = var.cluster_description
    iam_role_arn       = var.iam_role_arn
    node_type          = var.node_type
    cluster_endpoint_encryption_type = var.cluster_endpoint_encryption_type
    replication_factor = var.replication_factor
    parameter_group_name = var.parameter_group_name
    subnet_group_name = aws_db_subnet_group.dax_subnet_group.name

  server_side_encryption {
    enabled = true
  }

}