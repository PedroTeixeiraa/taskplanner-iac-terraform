module "network" {
  source = "../../modules/network"
}

resource "aws_ecs_cluster" "taskplanner_ecs_cluster" {
  name = "taskplanner-ecs-cluster"
}

# ECS TASK DEFINITION
resource "aws_ecs_task_definition" "taskplanner_task_definition" {
  family                   = "taskplanner-task-definition"
  container_definitions    = var.container_definitions
  execution_role_arn       = var.task_execution_role_arn
  task_role_arn            = var.task_role_arn
  network_mode             = var.task_network_mode
  requires_compatibilities = var.requires_compatibilities
  cpu                      = var.task_cpu
  memory                   = var.task_memory
}

resource "aws_ecs_service" "taskplanner_ecs_service" {
  name            = "taskplanner_ecs_service"
  cluster         = aws_ecs_cluster.taskplanner_ecs_cluster.id
  task_definition = aws_ecs_task_definition.taskplanner_task_definition.arn
  desired_count   = var.service_desired_count
  launch_type     = "FARGATE"

  network_configuration {
    subnets = module.network.public_subnets_ids
    security_groups = [module.network.lb_security_group_id]
    assign_public_ip = true
    
  }
  load_balancer {
    target_group_arn = aws_lb_target_group.task_planner_target_group.arn
    container_name   = "task-planner"
    container_port   = 3000
  }
}