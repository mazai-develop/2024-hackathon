resource "aws_vpc" "hackathon_2024_vpc" {
  cidr_block = "10.0.0.0/16"

  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "hackathon_2024_vpc"
  }
}

# Public Subnets
resource "aws_subnet" "public_1a" {
  vpc_id = aws_vpc.hackathon_2024_vpc.id

  availability_zone = "ap-northeast-1a"
  cidr_block        = "10.0.1.0/24"

  map_public_ip_on_launch = true

  tags = {
    Name = "hackathon_2024_public_1a"
  }
}

# Public Subnets
resource "aws_subnet" "public_1c" {
  vpc_id = aws_vpc.hackathon_2024_vpc.id

  availability_zone = "ap-northeast-1a"
  cidr_block        = "10.0.2.0/24"

  map_public_ip_on_launch = true

  tags = {
    Name = "hackathon_2024_public_1c"
  }
}

# Private Subnets
resource "aws_subnet" "private_1a" {
  vpc_id = aws_vpc.hackathon_2024_vpc.id

  availability_zone = "ap-northeast-1a"
  cidr_block        = "10.0.3.0/24"

  tags = {
    Name = "hackathon_2024_private_1a"
  }
}

resource "aws_internet_gateway" "hackathon_2024_internet_gateway" {
  vpc_id = aws_vpc.hackathon_2024_vpc.id

  tags = {
    Name = "hackathon_2024_internet_gateway"
  }
}

resource "aws_route" "igw_route" {
  # 全てのトラフィックをIGWに送信するルーティング
  route_table_id         = aws_route_table.hackathon_2024_route_table.id
  gateway_id             = aws_internet_gateway.hackathon_2024_internet_gateway.id
  destination_cidr_block = "0.0.0.0/0"
}

resource "aws_route_table" "hackathon_2024_route_table" {
  vpc_id = aws_vpc.hackathon_2024_vpc.id

  tags = {
    Name = "hackathon_2024_route_table"
  }
}

resource "aws_route_table_association" "a" {
  # igwにルーティングするroute_tableをパブリックサブネット(public_1a)に紐付け
  subnet_id      = aws_subnet.public_1a.id
  route_table_id = aws_route_table.hackathon_2024_route_table.id
}

resource "aws_route_table_association" "c" {
  # igwにルーティングするroute_tableをパブリックサブネット(public_1c)に紐付け
  subnet_id      = aws_subnet.public_1c.id
  route_table_id = aws_route_table.hackathon_2024_route_table.id
}
