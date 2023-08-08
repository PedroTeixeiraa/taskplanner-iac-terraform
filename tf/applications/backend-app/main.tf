provider "aws" {
  region = var.aws_region
}

module "network" {
  source = "../../modules/network"
}

# LOAD BALANCER
resource "aws_lb" "task_planner_lb" {
  name               = "task-planner-lb"
  load_balancer_type = "application"
  subnets            = module.network.public_subnets_ids
  security_groups    = [module.network.lb_security_group_id]
  tags = {
    Name = "Taskplanner-ALB"
  }
}

# TARGET GROUP
resource "aws_lb_target_group" "task_planner_target_group" {
  name        = "task-planner-target-group"
  port        = 3000
  protocol    = "HTTP"
  vpc_id      = module.network.vpc_id
  target_type = "ip"

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    interval            = 30
    matcher             = "200-299"
    path                = "/tasks"
    protocol            = "HTTP"
    port                = "traffic-port"
  }
}

# LISTENER 
resource "aws_lb_listener" "task_planner_http_listener" {
  load_balancer_arn = aws_lb.task_planner_lb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "redirect"
    redirect {
      protocol = "HTTPS"
      port     = "443"
      status_code  = "HTTP_301"
    }
  }
}

resource "aws_lb_listener" "task_planner_https_listener" {
  load_balancer_arn = aws_lb.task_planner_lb.arn
  port              = 443
  protocol          = "HTTPS"
  
  ssl_policy      = "ELBSecurityPolicy-2016-08"
  certificate_arn = var.certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.task_planner_target_group.arn
  }
}

# ROUTE 53
resource "aws_route53_record" "taskplanner-api_record" {
  zone_id = var.route53_zone_id
  name    = var.route53_record_name
  type    = "A"

  alias {
    name                   = aws_lb.task_planner_lb.dns_name
    zone_id                = aws_lb.task_planner_lb.zone_id
    evaluate_target_health = true
  }
}


# ECS CLUSTER
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
    # subnets = module.network.private_subnets_ids
    subnets = module.network.public_subnets_ids
    security_groups = [module.network.lb_security_group_id]
    # assign_public_ip = false
    assign_public_ip = true
    
  }
  load_balancer {
    target_group_arn = aws_lb_target_group.task_planner_target_group.arn
    container_name   = "task-planner"
    container_port   = 3000
  }
}