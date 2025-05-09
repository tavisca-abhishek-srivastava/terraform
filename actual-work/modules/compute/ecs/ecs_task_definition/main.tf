resource "aws_ecs_task_definition" "aws_ecs_task_definition_tf" {
  family = var.family
  requires_compatibilities = var.requires_compatibilities
  network_mode = var.network_mode
  cpu = var.cpu
  memory = var.memory
  execution_role_arn = var.execution_role_arn
  container_definitions = jsonencode([
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
     runtime_platform {
        operating_system_family = var.operating_system_family #"LINUX"
        cpu_architecture        = var.cpu_architecture  #"X86_64"
     }
     tags = {
        "AppName"            = "app-pgsql-task-definition-tf"
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