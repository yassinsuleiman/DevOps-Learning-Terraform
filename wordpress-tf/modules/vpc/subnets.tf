#Public Subnet
resource "aws_subnet" "public_1" {
  vpc_id     = aws_vpc.wp.id
  cidr_block = var.public_subnet_cidr
  map_public_ip_on_launch = true

  tags = {
    Name = "Wordpress"
  }
}
#Private Subnet
resource "aws_subnet" "private_1" {
  vpc_id     = aws_vpc.wp.id
  cidr_block = var.private_subnet_cidr

  tags = {
    Name = "Wordpress"
  }
}
#Route Table for Public Subnet
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

resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.wp.id 

  tags = {
    Name = "wp_private_rt"
  }
  
}
#Route Table Association for Public Subnet
resource "aws_route_table_association" "public_1_assoc" {
  subnet_id      = aws_subnet.public_1.id
  route_table_id = aws_route_table.public_rt.id
}
#Route Table Association for Private Subnet
resource "aws_route_table_association" "private_1_assoc" {  
  subnet_id      = aws_subnet.private_1.id
  route_table_id = aws_route_table.private_rt.id
}
