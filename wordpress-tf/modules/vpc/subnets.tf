# fetch AZs in the region
data "aws_availability_zones" "available" {
  state = "available"
}

# Public Subnet 1 (AZ-a)
resource "aws_subnet" "public_1" {
  vpc_id                  = aws_vpc.wp.id
  cidr_block              = var.public1_subnet_cidr
  availability_zone       = data.aws_availability_zones.available.names[0]
  map_public_ip_on_launch = true

  tags = {
    Name = "wp-public-1a"
  }
}

# Public Subnet 2 (AZ-b)
resource "aws_subnet" "public_2" {
  vpc_id                  = aws_vpc.wp.id
  cidr_block              = var.public2_subnet_cidr
  availability_zone       = data.aws_availability_zones.available.names[1]
  map_public_ip_on_launch = true

  tags = {
    Name = "wp-public-1b"
  }
}

# Private Subnet 1 (AZ-a)
resource "aws_subnet" "private_1" {
  vpc_id            = aws_vpc.wp.id
  cidr_block        = var.private1_subnet_cidr
  availability_zone = data.aws_availability_zones.available.names[0]

  tags = {
    Name = "wp-private-1a"
  }
}

# Private Subnet 2 (AZ-b)
resource "aws_subnet" "private_2" {
  vpc_id            = aws_vpc.wp.id
  cidr_block        = var.private2_subnet_cidr
  availability_zone = data.aws_availability_zones.available.names[1]

  tags = {
    Name = "wp-private-1b"
  }
}

# Public Route Table
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.wp.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "public_rt"
  }
}

# Private Route Table
resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.wp.id

  tags = {
    Name = "wp_private_rt"
  }
}

# Route-table Associations
resource "aws_route_table_association" "public_1_assoc" {
  subnet_id      = aws_subnet.public_1.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "public_2_assoc" {
  subnet_id      = aws_subnet.public_2.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "private_1_assoc" {
  subnet_id      = aws_subnet.private_1.id
  route_table_id = aws_route_table.private_rt.id
}

resource "aws_route_table_association" "private_2_assoc" {
  subnet_id      = aws_subnet.private_2.id
  route_table_id = aws_route_table.private_rt.id
}