variable "ecs_cluster_name" {
  type    = string
  default = "iac-ecs-testing-tf-sl"
}

variable "ecs_service_name_pgsql" {
  type    = string
  default = "pgsql_node_service"
}

# variable "pgsql_task_definition" {
#   type    = string
#   default = "arn:aws:ecs:us-east-1:928814396842:task-definition/pgsql-app-task-definition:1"
# }

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
  description = "A unique name for your task definition"
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
  default = 3072
  type    = number
  description = "Number of cpu units used by the task. If the requires_compatibilities is FARGATE this field is required."

}

variable "memory" {
  default = 10000
  type    = number
  description = "value"
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
    "name"      = "app_pgsql_tf_container",   #The name of a container. If you're linking multiple containers together in a task definition, the name of one container can be entered in the links of another container to connect the containers. Up to 255 letters (uppercase and lowercase), numbers, underscores, and hyphens are allowed. This parameter maps to name in the docker container create command and the --name option to docker run.
    "image"     = "928814396842.dkr.ecr.us-east-1.amazonaws.com/atlas/pg:latest",
    "cpu"       = 1024,   # The number of cpu units reserved for the container. This parameter maps to CpuShares in the docker container create commandand the --cpu-shares option to docker run. This field is optional for tasks using the Fargate launch type, and the only requirement is that the total amount of CPU reserved for all containers within a task be lower than the task-level cpu value.
    "memory"    = 3072,   #The amount (in MiB) of memory to present to the container. If your container attempts to exceed the memory specified here, the container is killed. The total amount of memory reserved for all containers within a task must be lower than the task memory value, if one is specified. This parameter maps to Memory in the docker container create command and the --memory option to docker run.
    "essential" = true,  #If the essential parameter of a container is marked as true, and that container fails or stops for any reason, all other containers that are part of the task are stopped. If the essential parameter of a container is marked as false, its failure doesn't affect the rest of the containers in a task. If this parameter is omitted, a container is assumed to be essential.
    "portMappings" = [
      {
        "containerPort" = 8000
        "hostPort"      = 8000
      }
    ],
    },
  ]
}