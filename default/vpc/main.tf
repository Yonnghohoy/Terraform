############## VPC ###############
resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr_block
  tags = {
    Name = "${var.name}-test-vpc"
  }
}

########## Public Subnet #########
resource "aws_subnet" "public_subnets" {
  for_each = var.public_subnets
  
  availability_zone = each.value["az"]
  cidr_block = each.value["cidr"]
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.name}-${each.key}"
  }
}

########## Private Subnet ############
resource "aws_subnet" "private_subnets" {
  for_each = var.private_subnets

  availability_zone = each.value["az"]
  cidr_block = each.value["cidr"]
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.name}-${each.key}"
  }
}

resource "aws_subnet" "rds_subnets" {
  for_each = var.rds_subnets

  availability_zone = each.value["az"]
  cidr_block = each.value["cidr"]
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.name}-${each.key}"
  }
}

################# IGW ###################
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.name}-igw"
  }
}

################### Public RTB ######################
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  } 

  tags = {
    Name = "${var.name}-pub-rtb"
  }
}

################### Private RTB ######################
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gw.id
  }

  tags = {
    Name = "${var.name}-pri-rtb"
  }
}

################### RDS RTB ######################
resource "aws_route_table" "rds" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gw.id
  }

  tags = {
    Name = "${var.name}-pri-rds-rtb"
  }
}

############# Association #############
resource "aws_route_table_association" "public" {
  for_each = aws_subnet.public_subnets
  
  subnet_id = each.value.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "private" {
  for_each = aws_subnet.private_subnets

  subnet_id = each.value.id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "rds" {
  for_each = aws_subnet.rds_subnets

  subnet_id = each.value.id
  route_table_id = aws_route_table.rds.id
}

########### NAT #############
resource "aws_eip" "eip" {
  vpc = true
  tags = {
    Name = "${var.name}-eip"
  }
}

resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.eip.id
  subnet_id = aws_subnet.public_subnets["pub-sub-1"].id

  tags = {
    Name = "${var.name}-nat-gw"
  }
}


