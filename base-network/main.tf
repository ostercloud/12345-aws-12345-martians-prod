data "aws_availability_zones" "available" {
  state = "available"
}

### AWS VPC
resource "aws_vpc" "vpc" {
  cidr_block           = "${var.vpc_cidr_range}"
  instance_tenancy     = "${var.instance_tenancy}"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"

  tags {
    Environment = "${var.environment}"
    Provisioner = "martian"
    Name        = "${var.name}"
  }
}

### Internet Gateway
resource "aws_internet_gateway" "internet" {
  vpc_id = "${aws_vpc.vpc.id}"

  tags {
    Environment = "${var.environment}"
    Name        = "${var.name}-IGW"
    Provisioner = "martian"
  }
}

### Private Subnets
# Loop over this as many times as necessary to create the correct number of Private Subnets
resource "aws_subnet" "private_subnet" {
  count             = "${var.availability_zones_count}"
  vpc_id            = "${aws_vpc.vpc.id}"
  cidr_block        = "${element(var.private_subnets, count.index)}"
  availability_zone = "${element(data.aws_availability_zones.available.names, count.index)}"

  tags {
    Environment = "${var.environment}"
    Name        = "${format("%s-private-subnet-az%d", var.name, count.index + 1)}"
    Network     = "private"
    Provisioner = "martian"
  }
}

### Public Subnets
# Loop over this as many times as necessary to create the correct number of Public Subnets
resource "aws_subnet" "public_subnet" {
  count             = "${var.availability_zones_count}"
  vpc_id            = "${aws_vpc.vpc.id}"
  cidr_block        = "${element(var.public_subnets, count.index)}"
  availability_zone = "${element(data.aws_availability_zones.available.names, count.index)}"

  tags {
    Environment = "${var.environment}"
    Name        = "${format("%s-public-subnet-az%d", var.name, count.index + 1 )}"
    Network     = "public"
    Provisioner = "martian"
  }
}

### Elastic IPs
# Need one per AZ for the NAT Gateways
resource "aws_eip" "nat_gw_eip" {
  count = "${var.availability_zones_count}"
  vpc   = true
}

### NAT Gateways
# Loops as necessary to create one per AZ in the Public Subnets, and associate the provisioned Elastic IP
resource "aws_nat_gateway" "nat" {
  allocation_id = "${element(aws_eip.nat_gw_eip.*.id, count.index)}"
  count         = "${var.availability_zones_count}"
  subnet_id     = "${element(aws_subnet.public_subnet.*.id, count.index)}"

  tags {
    Environment = "${var.environment}"
    Name        = "${format("%s-nat-gateway-az%d", var.name, count.index + 1 )}"
    Provisioner = "martian"
  }
}

### Private Subnet Route Tables
# Routes traffic destined for `0.0.0.0/0` to the NAT Gateway in the same AZ
resource "aws_route_table" "route_table_private" {
  count  = "${var.availability_zones_count}"
  vpc_id = "${aws_vpc.vpc.id}"

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = "${element(aws_nat_gateway.nat.*.id, count.index)}"
  }

  tags {
    Environment = "${var.environment}"
    Name        = "${format("%s-PrivateRT-AZ%d", var.name, count.index +1)}"
    Provisioner = "martian"
  }
}

### Private Subnet Route Table Associations
resource "aws_route_table_association" "private_subnet_assocation" {
  count          = "${var.availability_zones_count}"
  subnet_id      = "${element(aws_subnet.private_subnet.*.id, count.index)}"
  route_table_id = "${element(aws_route_table.route_table_private.*.id, count.index)}"
}

### Public Route Tables
# Routes traffic destined for `0.0.0.0/0` to the Internet Gateway for the VPC
resource "aws_route_table" "route_table_public" {
  vpc_id = "${aws_vpc.vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.internet.id}"
  }

  tags {
    Environment = "${var.environment}"
    Name        = "${format("%s-PublicRT", var.name)}"
    Provisioner = "martian"
  }
}

### Public Route Table Associations
resource "aws_route_table_association" "public_subnet_assocation" {
  count          = "${var.availability_zones_count}"
  subnet_id      = "${element(aws_subnet.public_subnet.*.id, count.index)}"
  route_table_id = "${aws_route_table.route_table_public.id}"
}
