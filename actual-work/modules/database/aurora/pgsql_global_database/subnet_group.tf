module "nrt_rds_subnet_group" {
	  source = "../../common_components/rds_aurora/aws_db_subnet_group_multi_region/"
	  ### if var.use_default_subnet_group == false then it will create new subnet group else will use default subnet group provided by user
	  for_each = (var.use_default_subnet_group == false) ? toset(["1"]):toset([])
	  subnet_group_name = "${var.cluster_identifier}-subnet-group"
	  subnet_group_subnet_ids = var.subnet_group_subnet_ids
        providers = {
                    aws.instancemaker = aws.primary
                    }

	  tags = var.tags
}

module "nrt_rds_subnet_group_or" {
	  source = "../../common_components/rds_aurora/aws_db_subnet_group_multi_region/"
	  ### if var.use_default_subnet_group == false then it will create new subnet group else will use default subnet group provided by user
	  for_each = (var.use_default_subnet_group == false) ? toset(["1"]):toset([])
	  subnet_group_name = "${var.cluster_identifier}-subnet-group"
	  subnet_group_subnet_ids = var.subnet_group_subnet_ids_or
        providers = {
                    aws.instancemaker = aws.replica
                    }

	  tags = var.tags
}