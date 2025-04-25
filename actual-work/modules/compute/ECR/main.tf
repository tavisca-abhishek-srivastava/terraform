resource "aws_ecr_repository" "nrt-pg-repo" {
  name                 = "atlas/pg"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = false
  }
  tags = {
      InfraOwner : "sre-cloud-reliability@tavisca.com"
      Product : "poap"
      Name : "atlas/pg"
  }
}