aws_region = "us-east-1"
load_balancer_name   = "my-backend-load-balancer-dev"
target_group_name    = "my-backend-target-group-dev"
task_family          = "my-backend-task-family-dev"
container_definitions = <<EOF
[
  {
    "name": "backend-container",
    "image": "my-registry/my-backend-image:latest",
    "cpu": 256,
    "memory": 512,
    "portMappings": [
      {
        "containerPort": 80,
        "protocol": "tcp"
      }
    ],
    "essential": true
  }
]
EOF
task_execution_role_arn = "arn:aws:iam::123456789012:role/ecs-task-execution-role"
task_role_arn           = "arn:aws:iam::123456789012:role/ecs-task-role"
certificate_arn         = "arn:aws:acm:us-east-1:123123123:certificate/f940ac85-f513-45e3-9e51-f31a9342bde6"
route53_zone_id         = "Z0123456789ABCDE"
route53_record_name     = "my-backend.example.com"