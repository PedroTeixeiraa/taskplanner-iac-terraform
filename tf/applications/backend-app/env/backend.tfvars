aws_region = "us-east-1"
container_definitions = <<EOF
[
  {
    "name": "backend-container",
    "image": "my-registry/my-backend-image:latest",
    "cpu": 1024,
    "memory": 3072,
    "portMappings": [
      {
        "containerPort": 3000,
        "hostPort": 3000,
        "protocol": "tcp"
      }
    ],
    "essential": true,
    "environment": [
      {
        "name": "AWS_SECRET_NAME",
        "value": "arn:aws:secretsmanager:us-east-1:242342424:secret:teste"
      },
      {
        "name": "AWS_REGION",
        "value": "us-east-1"
      }
    ]
  }
]
EOF
task_cpu = "1024"
task_memory = "3072"
task_execution_role_arn = "arn:aws:iam::123456789012:role/ecs-task-execution-role"
task_role_arn           = "arn:aws:iam::123456789012:role/ecs-task-role"
certificate_arn         = "arn:aws:acm:us-east-1:123123123:certificate/f940ac85-f513-45e3-9e51-f31a9342bde6"
route53_zone_id         = "Z0123456789ABCDE"
route53_record_name     = "my-backend.example.com"