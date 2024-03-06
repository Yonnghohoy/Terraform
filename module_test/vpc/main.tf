resource "aws_vpc" "vpc" {
  cidr_block	= var.vpc_cidr_block
}

resource "aws_subnet" "sjh-public" {
  vpc_id 	= aws_vpc.vpc.id
  cidr_block	= var.public_subnet_cidr_block
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.name}-public"
  }
}

resource "aws_subnet" "sjh-private" {
  vpc_id 	= aws_vpc.vpc.id
  cidr_block	= var.private_subnet_cidr_block
  tags = {
    Name = "${var.name}-private"
  }
}

resource "aws_internet_gateway" "sjh-igw" {
  vpc_id 	= aws_vpc.vpc.id
  tags = {
    Name = "${var.name}-igw"
  }
}

resource "aws_eip" "sjh-eip" {
  vpc	= true
  tags = {
    Name = "${var.name}-eip"
  }
}

resource "aws_nat_gateway" "sjh-ngw" {
  allocation_id = aws_eip.sjh-eip.id
  subnet_id 	= aws_subnet.sjh-public.id
  tags = {
    Name = "${var.name}-ngw"
  }
}

resource "aws_route_table" "sjh-public-rtb" {
  vpc_id	= aws_vpc.vpc.id
  tags = {
    Name = "${var.name}-public-rtb"
  }

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.sjh-igw.id
  }
}

resource "aws_route_table" "sjh-private-rtb" {
  vpc_id	= aws_vpc.vpc.id
  tags = {
    Name = "${var.name}-private-rtb"
  }

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.sjh-ngw.id
  }
}

resource "aws_route_table_association" "public" {
  subnet_id	= aws_subnet.sjh-public.id
  route_table_id = aws_route_table.sjh-public-rtb.id
}

resource "aws_route_table_association" "private" {
  subnet_id 	= aws_subnet.sjh-private.id
  route_table_id = aws_route_table.sjh-private-rtb.id
}

