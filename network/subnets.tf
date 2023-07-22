# network/subnets.tf

variable "public_subnet_cidr_blocks" {
  description = "CIDR blocks for the public subnets"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnet_cidr_blocks" {
  description = "CIDR blocks for the private subnets"
  type        = list(string)
  default     = ["10.0.3.0/24", "10.0.4.0/24"]
}

variable "availability_zones" {
  description = "Availability Zones for the subnets"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
}

resource "aws_subnet" "taskplanner_public_subnet" {
  count = length(var.public_subnet_cidr_blocks)

  vpc_id            = aws_vpc.taskplanner_vpc.id
  cidr_block        = var.public_subnet_cidr_blocks[count.index]
  availability_zone = var.availability_zones[count.index]

  map_public_ip_on_launch = true

  tags = {
    Name = "TaskPlannerPublicSubnet${count.index + 1}"
  }
}

resource "aws_subnet" "taskplanner_private_subnet" {
  count = length(var.private_subnet_cidr_blocks)

  vpc_id            = aws_vpc.taskplanner_vpc.id
  cidr_block        = var.private_subnet_cidr_blocks[count.index]
  availability_zone = var.availability_zones[count.index]

  tags = {
    Name = "TaskPlannerPrivateSubnet${count.index + 1}"
  }
}

