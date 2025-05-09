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

variable "memory" {
  default = 3072
  type = number

}

variable "execution_role_arn" {
  default = "arn:aws:iam::928814396842:role/ecsTaskExecutionRole"
  type = string

}

variable "cpu" {
  default = 1024
  type = number

}
variable "operating_system_family" {
  default = "LINUX"
}
variable "cpu_architecture" {
  default = "X86_64"
}