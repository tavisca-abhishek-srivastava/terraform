resource "aws_ecs_service" "pgsql_node" {
  name            = "pgsql_node_service"
  cluster         = "iac-ecs-testing-tf-sl"
  task_definition = "arn:aws:ecs:us-east-1:928814396842:task-definition/pgsql-app-task-definition:1"
  desired_count   = 1
  enable_ecs_managed_tags = true
  launch_type = "FARGATE"
  propagate_tags = "TASK_DEFINITION"
  network_configuration {
   subnets         = ["subnet-001023c820ce7e35c","subnet-04c8a1cce0a80f526","subnet-08792a1a703950fe7"]
   security_groups = ["sg-0529be6bea90f8657","sg-02dfd3936c47a6a7c"]
   assign_public_ip = false
 }
 force_new_deployment = true
tags = {
    "AppName"            = "pgsql_node_service"
    "Backup"             = "false"
    "BusinessUnit"       = "travel.poc"
    "DataClassification" = "internal"
    "Environment"        = "poc"
    "InfraOwner"         = "sre-cloud-reliability@tavisca.com"
    "Name"               = "pgsql_node_service"
    "ProductOwner"       = "sre-cloud-reliability@tavisca.com"
    "Product"            = "poap"
    "Squad"              = "travel.poc"
  } 

}