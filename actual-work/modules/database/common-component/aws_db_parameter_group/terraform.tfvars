rds_parameter_group_name = "rds-mysql"
family = "mysql5.6"

parameter_value = {
  setting1 = {
    name = "character_set_server"
    value = "utf8"},
  setting2 = {
    name = "character_set_server"
    value = "utf8"},
  setting3 = {
    name = "autocommit"
    value = 1},
}
tags = {
  DataClassification : "restricted"
  Environment : "poc"
  AppName : "tf-nrt-nrt-iac-rds-parameter-group"
  InfraOwner : "sre-cloud-reliability@tavisca.com"
  BusinessUnit : "travel.app"
  Backup : "no"
  Product : "poap"
  Name : "tf-nrt-iac-rds-parameter-group"
  }