resource "aws_vpc" "vpc" {
  cidr_block	= var.vpc_cidr_block
  enable_dns_hostnames = true
  tags = {
    Name = "${var.base_name}-test-vpc"
  }
}

resource "aws_subnet" "public" {
  for_each = var.public_subnets

  vpc_id 	= aws_vpc.vpc.id
  cidr_block	= each.value["cidr"]
  availability_zone = each.value["az"]
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.base_name}-public-${each.key}"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id 	= aws_vpc.vpc.id
  tags = {
    Name = "${var.base_name}-igw"
  }
}

resource "aws_route_table" "public" {
  vpc_id	= aws_vpc.vpc.id
  tags = {
    Name = "${var.base_name}-public-rtb"
  }

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

resource "aws_route_table_association" "public" {
  for_each 	= var.public_subnets
  subnet_id	= aws_subnet.public[each.key].id
  route_table_id = aws_route_table.public.id
}

