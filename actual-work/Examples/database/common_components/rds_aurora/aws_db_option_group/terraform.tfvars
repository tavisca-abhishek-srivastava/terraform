aws_region = "us-east-1"
rds_option_group_name = "nrt-rds-mysql"
engine_name = "mysql"
major_engine_version = "8.0"
option_group_description = "This is for NRT RDS"
option_settings = {
  "setting1" = {
    option_name           = "MEMCACHED"
    option_settings_name  = "BACKLOG_QUEUE_LIMIT"
    option_settings_value = "1025"
    db_security_group_memberships = "default"
    vpc_security_group_memberships = "default"
    port = 11211
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