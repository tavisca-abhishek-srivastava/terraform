module "ecs_task_definition" {
  source                   = "../ecs_task_definition"
  memory                   = var.memory
  cpu                      = var.cpu
  container_definitions    = var.container_definitions
  operating_system_family  = var.operating_system_family
  family                   = var.family
  execution_role_arn       = var.execution_role_arn
  network_mode             = var.network_mode
  requires_compatibilities = var.requires_compatibilities
  cpu_architecture         = var.cpu_architecture

}


resource "aws_ecs_service" "pgsql_node" {
  name                    = var.ecs_service_name_pgsql 
  cluster                 = var.ecs_cluster_name      
  task_definition         = module.ecs_task_definition.task_definition_arn
  desired_count           = var.desired_count_tasks
  enable_ecs_managed_tags = true
  launch_type             = var.launch_type
  propagate_tags          = "TASK_DEFINITION"
  network_configuration {
    subnets          = var.subnets        
    security_groups  = var.security_groups 
    assign_public_ip = local.assign_public_ip
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