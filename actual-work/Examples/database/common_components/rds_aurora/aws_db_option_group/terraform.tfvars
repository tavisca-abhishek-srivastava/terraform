aws_region = "us-east-1"
rds_option_group_name = "nrt-rds-mysql"
engine_name = "mysql"
major_engine_version = "8.0"
option_group_description = "This is for NRT RDS"
option_settings = {
    option_name           = "Timezone"
    option_settings_name  = "TIME_ZONE"
    option_settings_value = "UTC"
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