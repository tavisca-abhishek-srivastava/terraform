

resource "aws_rds_cluster" "postgresql_or" {
  cluster_identifier      = "${var.cluster_identifier}-or"
  engine                  = "aurora-postgresql"
  engine_version          =  16.4
  availability_zones      = ["us-west-2a", "us-west-2b", "us-west-2c"]
  backup_retention_period = var.backup_retention_period
  #preferred_backup_window = "07:00-09:00"
  skip_final_snapshot = true
  apply_immediately = true
  kms_key_id = module.rds_encryption_at_rest_cmk.replica_mrk_cms_arn[0]
  storage_encrypted = true
  global_cluster_identifier = "${aws_rds_global_cluster.nrt_gdc.id}"
  provider = aws.replica

  db_subnet_group_name = module.nrt_rds_subnet_group_or["1"].subnet_name
  tags = var.tags
  
  		timeouts{
			create = local.terrform_operation_timeout
			delete = local.terrform_operation_timeout
			update = local.terrform_operation_timeout
  					}

}

resource "aws_rds_cluster_instance" "cluster_instances_or" {
  for_each              =   var.instance_role_or
  identifier            =   "nrt-aurora-gd-cluster-poc-${each.value.name}"
  availability_zone     =   each.value.az
  cluster_identifier    =   aws_rds_cluster.postgresql_or.id
  instance_class        =   "db.r6g.large"
  engine                =   aws_rds_cluster.postgresql_or.engine
  engine_version        =   aws_rds_cluster.postgresql_or.engine_version
  db_subnet_group_name =    module.nrt_rds_subnet_group_or["1"].subnet_name
  db_parameter_group_name = module.nrt_rds_parameter_group.parameter_group_name_or
  promotion_tier = each.value.promotion_tier
  performance_insights_enabled = true
  performance_insights_kms_key_id = module.rds_encryption_at_rest_cmk.replica_mrk_cms_arn[0] #"arn:aws:kms:us-east-1:346319152574:key/mrk-4eca0415b8b4434f96399c2f2d80b1ef"
  performance_insights_retention_period = 7
  provider = aws.replica
}