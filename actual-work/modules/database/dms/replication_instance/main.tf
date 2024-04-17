resource "aws_dms_replication_instance" "test" {
  allocated_storage            = 20
  apply_immediately            = true
  auto_minor_version_upgrade   = true
  availability_zone            = "us-east-1a"
  engine_version               = "3.5.2"
  kms_key_arn                  = "arn:aws:kms:us-east-1:928814396842:key/7cf40c49-d85b-45ff-980a-edd8dcb2f6b9"
  multi_az                     = false
  preferred_maintenance_window = "sun:10:30-sun:14:30"
  publicly_accessible          = false
  replication_instance_class   = "dms.t3.large"
  replication_instance_id      = "dms-replication-instance-iac"
  replication_subnet_group_id  = "dms-subnet-group-iac"
  network_type = "IPV4"

  tags = {
   DataClassification : "restricted"
  Environment : "poc"
  AppName : "dms-replication-instance-iac"
  InfraOwner : "sre-cloud-reliability@tavisca.com"
  BusinessUnit : "travel.poc"
  Backup : "no"
  Product : "poap"
  Name : "dms-replication-instance-iac"
  }

  vpc_security_group_ids = [
    "sg-0a5fde676918b06a9",
  ]

  
}