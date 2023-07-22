# network/internet_gateway.tf

resource "aws_internet_gateway" "taskplanner_igw" {
  vpc_id = aws_vpc.taskplanner_vpc.id

  tags = {
    Name = "TaskPlannerIGW"
  }
}