resource "aws_ecs_task_definition" "name" {
  family = "pgsql-app-task-definition-tf"
  requires_compatibilities = ["FARGATE"]
  network_mode = "awsvpc"
  cpu = 1024
  memory = 2048
  container_definitions = jsonencode([
    {
      "name": "app-pgsql-task-definition-tf",
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
        operating_system_family = "LINUX"
        cpu_architecture        = "X86_64"
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