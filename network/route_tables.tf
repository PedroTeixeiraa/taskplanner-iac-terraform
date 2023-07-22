# network/route_tables.tf

resource "aws_route_table" "taskplanner_public_route_table" {
  vpc_id = aws_vpc.taskplanner_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.taskplanner_igw.id
  }

  tags = {
    Name = "TaskPlannerPublicRouteTable"
  }
}

resource "aws_route_table_association" "public_subnet_associations" {
  count = length(var.public_subnet_cidr_blocks)

  subnet_id      = aws_subnet.taskplanner_public_subnet.*.id[count.index]
  route_table_id = aws_route_table.taskplanner_public_route_table.id
}

resource "aws_route_table" "taskplanner_private_route_table" {
  vpc_id = aws_vpc.taskplanner_vpc.id

  tags = {
    Name = "TaskPlannerPrivateRouteTable"
  }
}

resource "aws_route_table_association" "public_private_associations" {
  count = length(var.private_subnet_cidr_blocks)

  subnet_id      = aws_subnet.taskplanner_private_subnet.*.id[count.index]
  route_table_id = aws_route_table.taskplanner_private_route_table.id
}
