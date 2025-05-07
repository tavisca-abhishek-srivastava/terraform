variable "ecs_cluster_name" {
    type = string
    default = "iac-ecs-testing-tf-sl"
}

variable "ecs_service_name_pgsql" {
    type = string
    default = "pgsql_node_service"
}

variable "pgsql_task_definition" {
  type = string
  default = "arn:aws:ecs:us-east-1:928814396842:task-definition/pgsql-app-task-definition:1"
}

variable "desired_count_tasks" {
  type = number
  description = "desired_count for tasks"
  default = 3
}

variable "launch_type" {
  type = string
  default = "FARGATE"
}

variable "subnets" {
  type = list(string)
  default = ["subnet-001023c820ce7e35c","subnet-04c8a1cce0a80f526","subnet-08792a1a703950fe7"]
}

variable "subnet" {
  type = list(string)
  default = ["sg-0529be6bea90f8657","sg-02dfd3936c47a6a7c"]
}