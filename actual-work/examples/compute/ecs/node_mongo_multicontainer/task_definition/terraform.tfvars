family = "node-mongo-app-task-definition-tf"
requires_compatibilities = ["FARGATE"]
network_mode = "awsvpc"
cpu = 4096
memory = 8192
execution_role_arn = "arn:aws:iam::928814396842:role/ecsTaskExecutionRole"
operating_system_family = "LINUX"
cpu_architecture = "X86_64"
container_definitions = [
    {
      "name" = "app-node-container",
      "image"     = "928814396842.dkr.ecr.us-east-1.amazonaws.com/atlas/node-mongo-app:latest",
      "cpu"      = 1024,
      "memory"    = 3072,
      "essential" = true,
      environment = [
        {
          name = "MONGO_USER",
          value = "mongo"
        },
        {
          name = "MONGO_PASSWORD",
          value = "password"
        },
        {
          name = "MONGO_IP",
          value = "mongo"
        },
        {
          name = "MONGO_PORT",
          value = "27017"
        }
      ],
      "portMappings" = [
        {
          "containerPort" = 3000
          "hostPort"      = 3000
        }
      ],      
    },
    {
      "name" = "app-mongo-container",
      "image"     = "mongo",
      "cpu"      = 1024,
      "memory"    = 3072,
      "essential" = true,
      environment = [
        {
          name = "MONGO_INITDB_ROOT_USERNAME",
          value = "mongo"
        },
        {
          name = "MONGO_INITDB_ROOT_PASSWORD",
          value = "password"
        }
      ],
    },
    
]
