resource "aws_dms_replication_subnet_group" "example" {
  replication_subnet_group_description = "dms-subnet-group-iac"
  replication_subnet_group_id          = "dms-subnet-group-iac"

  subnet_ids = ["subnet-01d4d19deaa34db85","subnet-061e332b24aecd27b","subnet-060048463710e54c4" ]

  tags = {

  DataClassification : "restricted"
  Environment : "poc"
  AppName : "dms-iac-subnet-group"
  InfraOwner : "sre-cloud-reliability@tavisca.com"
  BusinessUnit : "travel.poc"
  Backup : "no"
  Product : "poap"
  Name : "dms-iac-subnet-group"

}

}
