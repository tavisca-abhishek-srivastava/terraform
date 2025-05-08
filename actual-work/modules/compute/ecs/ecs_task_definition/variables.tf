variable "family" {
  default = "pgsql-app-task-definition-tf"
  type = string
  }

variable "requires_compatibilities" {
  default = ["FARGATE"]
  type = list(string)

}
variable "network_mode" {
  default = "awsvpc"
  type = string

}

variable "cpu" {
  default = 1024
  type = number

}

  memory = 3072
  execution_role_arn = "arn:aws:iam::928814396842:role/ecsTaskExecutionRole"