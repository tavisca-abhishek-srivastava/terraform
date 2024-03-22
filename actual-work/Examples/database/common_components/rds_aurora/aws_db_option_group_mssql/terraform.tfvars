aws_region = "us-east-1"
rds_option_group_name = "nrt-rds-mssql"
option_group_engine_name = "sqlserver-ee"
option_group_major_engine_version = "15.00"
option_group_description = "This is for NRT RDS"
option_settings = {
  "setting1" = {
    option_name           = "SQLSERVER_BACKUP_RESTORE"
    option_settings_name  = "IAM_ROLE_ARN"
    option_settings_value = "arn:aws:iam::928814396842:role/tf-role-testing"  # make sure to add below line in "trust relationship of IAM role"
#     {
#     "Version": "2012-10-17",
#     "Statement":
#     [{
#         "Effect": "Allow",
#         "Principal": {"Service":  "rds.amazonaws.com"},
#         "Action": "sts:AssumeRole"
#     }]
# }
    db_security_group_memberships = null
    vpc_security_group_memberships = null
    port = null
  }
}


tags = {
  DataClassification : "restricted"
  Environment : "poc"
  AppName : "tf-nrt-nrt-iac-rds-option-group"
  InfraOwner : "sre-cloud-reliability@tavisca.com"
  BusinessUnit : "travel.app"
  Backup : "no"
  Product : "poap"
  Name : "tf-nrt-iac-rds-option-group"
  }