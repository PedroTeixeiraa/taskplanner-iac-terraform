# network/vpc.tf


variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  default     = "10.0.0.0/16"
}

resource "aws_vpc" "taskplanner_vpc" {
  cidr_block = var.vpc_cidr_block

  tags = {
    Name = "TaskPlannerVPC"
  }
}