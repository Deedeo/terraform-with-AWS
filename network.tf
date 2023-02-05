resource "aws_vpc" "vpc" {
  cidr_block           = var.cidr_block
  enable_dns_hostnames = true

  tags = local.common_tags
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = local.common_tags
}



resource "aws_subnet" "subnets" {
  count = var.vpc_subnet_count
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.vpc_subnets_cidr_block[count.index]
  map_public_ip_on_launch = "true"
  availability_zone       = data.aws_availability_zones.available.names[count.index]

  tags = local.common_tags
}



resource "aws_route_table" "rt" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = local.common_tags
}

resource "aws_route_table_association" "rta-subnets" {
  count          = var.vpc_subnet_count
  subnet_id      = aws_subnet.subnets[count.index].id
  route_table_id = aws_route_table.rt.id
}


