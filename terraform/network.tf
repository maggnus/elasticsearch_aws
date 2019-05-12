resource "aws_vpc" "es_vpc" {
  cidr_block = "${var.vpc_cidr}"

  tags = {
    Name = "es_vpc"
  }
}

resource "aws_subnet" "es_vpc_subnet" {
  vpc_id     = "${aws_vpc.es_vpc.id}"
  cidr_block = "${var.vpc_subnet_cidr}"

  tags = {
    Name = "es_vpc_subnet"
  }
}

resource "aws_internet_gateway" "es_vpc_gw" {
  vpc_id = "${aws_vpc.es_vpc.id}"

  tags {
    Name = "es_vpc_gw"
  }
}

resource "aws_route_table" "es_route_table" {
  vpc_id = "${aws_vpc.es_vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.es_vpc_gw.id}"
  }

  tags {
    Name = "es_route_table"
  }
}

resource "aws_route_table_association" "es_route_table_association" {
  subnet_id      = "${aws_subnet.es_vpc_subnet.id}"
  route_table_id = "${aws_route_table.es_route_table.id}"
}
