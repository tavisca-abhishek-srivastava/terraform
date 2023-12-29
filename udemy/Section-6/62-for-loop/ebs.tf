provider aws {
  region = "${var.aws_region}"
}

resource "aws_ebs_volume" "ebs_test_for_loop" {
  availability_zone = "us-east-1a"
  size = 8
  tags = {for k,v in merge({Name="tapoc_ebs_test_for_loop"},var.project_tags): k => v}
}