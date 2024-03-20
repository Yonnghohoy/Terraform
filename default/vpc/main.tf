resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr_block
  tags = {
    Name = "${var.name}-test-vpc"
  }
}

resource "aws_subnet" "public_subnets" {
  for_each = var.public_subnets
  
  availability_zone = each.value["az"]
  cidr_block = each.value["cidr"]
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.name}-${each.key}"
  }
}


resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.name}-igw"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  } 

  tags = {
    Name = "${var.name}-rtb"
  }
}

resource "aws_route_table_association" "public" {
  for_each = aws_subnet.public_subnets
  
  subnet_id = each.value.id
  route_table_id = aws_route_table.public.id
}

 
