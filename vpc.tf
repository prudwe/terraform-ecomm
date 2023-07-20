#ECOMM Infra setup

resource "aws_vpc" "ecomm" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "ECOMM-VPC"
  }
}


# Create Subnet for ECOMM VPC

resource "aws_subnet" "ecomm-subnet" {
  vpc_id     = aws_vpc.ecomm.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "ap-south-1a"
  map_public_ip_on_launch = true
  tags = {
    Name = "ECOMM-SUBNET"
  }
}


# Create Internet gateway 
resource "aws_internet_gateway" "ecomm-igw" {
  vpc_id = aws_vpc.ecomm.id

  tags = {
    Name = "ECOMM-IGW"
  }
}

#Create Route Table

resource "aws_route_table" "ecomm-rt" {
  vpc_id = aws_vpc.ecomm.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ecomm-igw.id
  }

  tags = {
    Name = "ECOMM-RT"
  }
}

# Route table association with subnet 

resource "aws_route_table_association" "ecomm-rt-association" {
  subnet_id      = aws_subnet.ecomm-subnet.id
  route_table_id = aws_route_table.ecomm-rt.id
}

