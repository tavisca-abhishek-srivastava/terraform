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

variable "container_definitions" {
  description = "A valid JSON container definition"
  type = any
  default = jsonencode([
    {
      name = "app-pgsql-task-definition-tf",
      image     = "928814396842.dkr.ecr.us-east-1.amazonaws.com/atlas/pg:latest",
      cpu       = 1024,
      memory    = 3072,
      essential = true,
      portMappings = [
        {
          containerPort = 8000
          hostPort      = 8000
        }
      ],


      
    },
     ])
}