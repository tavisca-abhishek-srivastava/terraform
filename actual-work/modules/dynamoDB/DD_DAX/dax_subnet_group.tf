resource "aws_dax_subnet_group" "dax_subnet_group" {
  name       = var.subnet_group_details.name
  subnet_ids = [var.subnet_group_details.subnet_id_1, var.subnet_group_details.subnet_id_2, var.subnet_group_details.subnet_id_3]
}
