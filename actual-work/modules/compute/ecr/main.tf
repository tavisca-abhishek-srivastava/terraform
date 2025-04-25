resource "aws_ecr_repository" "nrt-pg-repo" {
  name                 = "atlas/pg"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = false
  }
}