provider aws {
  region = "${var.aws_region}"
}

resource "aws_ebs_volume" "ebs_test_for_loop" {
  availability_zone = "us-east-1a"
  size = 8
  tags = {for k,v in merge({Name="tapoc_ebs_test_for_cb_data"},var.common_project_tags): k => v} #merging resource specific and common project tags
}

resource "aws_ebs_volume" "ebs_test_for_dse_data" {
  availability_zone = "us-east-1a"
  size = 8
  tags = {for k,v in merge({Name="tapoc_ebs_test_for_dse_data"},var.common_project_tags): k => v} #merging resource specific and common project tags
}

resource "aws_ebs_volume" "ebs_test_for_pg_data" {
  availability_zone = "us-east-1a"
  size = 8
  tags = {for_each k,v in merge({Name="tapoc_ebs_test_for_dse_data"},var.common_project_tags): k => v} #merging resource specific and common project tags
}