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
  replicate_source_db  = aws_db_instance.default.arn
  db_subnet_group_name = "default"

}