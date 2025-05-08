variable "family" {
  default = "pgsql-app-task-definition-tf"
  type = string
  }
  requires_compatibilities = ["FARGATE"]
  network_mode = "awsvpc"
  cpu = 1024
  memory = 3072
  execution_role_arn = "arn:aws:iam::928814396842:role/ecsTaskExecutionRole"