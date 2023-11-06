provider "aws" {
region="us-west-2"
}

resource "aws_db_instance" "read-only-cross-region" {
allocated_storage    = 11
  #engine               = "mysql"
  #engine_version       = "5.7"
  instance_class       = "db.t3.micro"
  #db_name                 = "mydb"
  #username             = "foo"
  #password             = "foobarbaz"
  parameter_group_name = "default.mysql5.7"
  skip_final_snapshot  = true
  availability_zone = "us-west-2a"
  identifier  = "jpmc-ro"
  apply_immediately = true
  replicate_source_db  = arn:aws:rds:us-east-1:928814396842:db:jpmc
  #db_subnet_group_name = "default"
  
  	  tags = {
		Name = "MasterMySQL"
		Owner = "DR-Testing"
		tool = "Terraform"
	  }

}