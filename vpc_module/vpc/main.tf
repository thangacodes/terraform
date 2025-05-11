# Data source to get availability zones
data "aws_availability_zones" "available" {}

resource "aws_vpc" "office" {
  cidr_block = var.cidr_block
  tags       = merge(var.tagging, { Name = "Office-Network" })
}

# Internet Gateway
resource "aws_internet_gateway" "office" {
  vpc_id = aws_vpc.office.id
}

# Public Subnets
resource "aws_subnet" "public" {
  count             = var.subnet_count
  vpc_id            = aws_vpc.office.id
  cidr_block        = cidrsubnet(var.cidr_block, 8, count.index)
  availability_zone = data.aws_availability_zones.available.names[count.index]
  tags              = merge(var.tagging, { Name = "Public-Subnet-${count.index}" })
}

# Create route table for Public Subnets
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.office.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.office.id
  }
  tags = merge(var.tagging, { Name = "Public-RouteTable" })
}

# Associate each public subnet with the public route table
resource "aws_route_table_association" "public" {
  count          = var.subnet_count
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}

# Private Subnets
resource "aws_subnet" "private" {
  count             = var.pvt_subnet_count
  vpc_id            = aws_vpc.office.id
  cidr_block        = cidrsubnet(var.cidr_block, 8, count.index + 10)
  availability_zone = data.aws_availability_zones.available.names[count.index]
  tags              = merge(var.tagging, { Name = "Private-Subnet-${count.index}" })
}

# Create Route table for private subnets
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.office.id
  route {
    cidr_block = "0.0.0.0/0"
  }
  tags = merge(var.tagging, { Name = "Private-RouteTable" })
}

# Associate each public subnet with the private route table
resource "aws_route_table_association" "private" {
  count          = var.pvt_subnet_count
  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private.id
}
