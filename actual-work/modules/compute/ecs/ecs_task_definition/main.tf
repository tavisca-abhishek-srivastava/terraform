resource "aws_ecs_task_definition" "aws_ecs_task_definition_tf" {
  family = var.family
  requires_compatibilities = var.requires_compatibilities
  network_mode = var.network_mode
  cpu = var.cpu
  memory = var.memory
  execution_role_arn = var.execution_role_arn
  container_definitions = jsonencode(var.container_definitions)
     runtime_platform {
        operating_system_family = var.operating_system_family
        cpu_architecture        = var.cpu_architecture
     }
     tags = {
        "AppName"            = "app-pgsql-task-definition-tf"
        "Backup"             = "no"
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