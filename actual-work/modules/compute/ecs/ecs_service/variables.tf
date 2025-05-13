variable "ecs_cluster_name" {
  type    = string
  default = "iac-ecs-testing-tf-sl"
}

variable "ecs_service_name_pgsql" {
  type    = string
  default = "pgsql_node_service"
}

variable "pgsql_task_definition" {
  type    = string
  default = "arn:aws:ecs:us-east-1:928814396842:task-definition/pgsql-app-task-definition:1"
}

variable "desired_count_tasks" {
  type        = number
  description = "desired_count for tasks"
  default     = 3
}

variable "launch_type" {
  type    = string
  default = "FARGATE"
}

variable "subnets" {
  type    = list(string)
  default = ["subnet-001023c820ce7e35c", "subnet-04c8a1cce0a80f526", "subnet-08792a1a703950fe7"]
}

variable "security_groups" {
  type        = list(string)
  description = "security group in list"
  default     = ["sg-0529be6bea90f8657", "sg-02dfd3936c47a6a7c"]
}

#######################################################################
##                                                                    #
##                                                                    #
##                                                                    #
######## variable for task definition   ###############################
##                                                                    #
##                                                                    #
######################################################################
variable "family" {
  default = "pgsql-app-task-definition-tf"
  type    = string
}

variable "requires_compatibilities" {
  default = ["FARGATE"]
  type    = list(string)

}
variable "network_mode" {
  default = "awsvpc"
  type    = string

}

variable "cpu" {
  default = 1024
  type    = number

}

variable "memory" {
  default = 3072
  type    = number

}

variable "execution_role_arn" {
  default = "arn:aws:iam::928814396842:role/ecsTaskExecutionRole"
  type    = string

}


variable "operating_system_family" {
  default = "LINUX"
}
variable "cpu_architecture" {
  default = "X86_64"
}

variable "container_definitions" {
  description = "A valid JSON container definition for task"
  type        = any
  default = [{
    "name"      = "app-pgsql-task-definition-tf",
    "image"     = "928814396842.dkr.ecr.us-east-1.amazonaws.com/atlas/pg:latest",
    "cpu"       = 1024,
    "memory"    = 3072,
    "essential" = true,
    "portMappings" = [
      {
        "containerPort" = 8000
        "hostPort"      = 8000
      }
    ],
    },
  ]
}