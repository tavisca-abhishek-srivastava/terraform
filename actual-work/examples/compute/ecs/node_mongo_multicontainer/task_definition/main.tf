module "name" {
  source = "../../../../../modules/compute/ecs/ecs_task_definition"
    family = var.family
    requires_compatibilities = var.requires_compatibilities
    network_mode = var.network_mode
    cpu = var.cpu
    memory = var.memory
    execution_role_arn = var.execution_role_arn
    operating_system_family = var.operating_system_family
    cpu_architecture = var.cpu_architecture
    container_definitions = var.container_definitions
}
