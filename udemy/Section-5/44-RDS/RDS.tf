provider "aws" {
  region = "us-east-1"
}

resource "aws_db_instance" "tapoc-mysql-rds" {
    allocated_storage    = 11
	  engine               = "mysql"
	  engine_version       = "5.7"
	  instance_class       = "db.t3.micro"
	  db_name                 = "mydb"
	  username             = "dbadmin"
	  password             = "welcome$123"
	  parameter_group_name = "default.mysql5.7"
	  skip_final_snapshot  = true
	  availability_zone = "us-east-1a"
	  identifier  = "jpmc-master"
	  apply_immediately = true
	  backup_retention_period = 1
	  multi_az = false
	  vpc_security_group_ids = ["${aws_security_group.ec2_security_groups.id}"]
	  tags = {           
              DataClassification: "restricted"
              Environment: "poc"
              AppName:  "tapoc-testing-mysql-rds"
              InfraOwner: "sre-cloud-reliability@tavisca.com"
              BusinessUnit: "travel.app"
              Backup: "no"
              Product: "poap"
              Name: "tapoc-testing-mysql-rds"
               }
	}

	output "arn" {
	value = aws_db_instance.tapoc-mysql-rds.arn
	description = "ARN of DB"
	 }