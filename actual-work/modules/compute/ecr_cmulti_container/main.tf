resource "aws_ecr_repository" "nrt-node-mongo-app-repo" {
  name                 = "atlas/node-mongo-app"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = false
  }
  tags = {
      InfraOwner : "sre-cloud-reliability@tavisca.com"
      Product : "poap"
      Name : "atlas/node-mongo-app"
  }
}