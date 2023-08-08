variable "aws_region" {
  description = "AWS region where resources will be provisioned."
}

variable "container_definitions" {
  description = "JSON encoded container definitions for the ECS task."
}

variable "task_execution_role_arn" {
  description = "ARN of the IAM role that allows ECS to execute tasks on your behalf."
}

variable "task_role_arn" {
  description = "ARN of the IAM role that allows containers in the task to call AWS services on your behalf."
}

variable "task_network_mode" {
  description = "The network mode to use for the ECS task."
  default     = "awsvpc"
}

variable "requires_compatibilities" {
  description = "A set of launch types required by the task."
  default     = ["FARGATE"]
}

variable "task_cpu" {
  description = "CPU units for the ECS task."
  default     = 256
}

variable "task_memory" {
  description = "Memory (in MiB) for the ECS task."
  default     = 512
}

variable "service_desired_count" {
  description = "Desired number of tasks to run in the service."
  default     = 2
}

variable "certificate_arn" {
  description = "Certificate Manager ARN"
}

variable "route53_zone_id" {
  description = "Zone ID of the Route 53 hosted zone."
}

variable "route53_record_name" {
  description = "DNS record name for the Route 53 record (e.g., myapp.example.com)."
}