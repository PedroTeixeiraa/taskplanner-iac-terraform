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