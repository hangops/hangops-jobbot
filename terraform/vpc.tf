# This data source is included for ease of sample architecture deployment
# and can be swapped out as necessary.
data "aws_availability_zones" "available" {}

resource "aws_vpc" "sntxrr" {
  cidr_block = "10.0.0.0/16"

  tags = "${
    map(
      "Name", "terraform-eks-sntxrr-node",
      "kubernetes.io/cluster/${var.cluster-name}", "shared",
    )
  }"
}

resource "aws_subnet" "sntxrr" {
  count = 2

  availability_zone = "${data.aws_availability_zones.available.names[count.index]}"
  cidr_block        = "10.0.${count.index}.0/24"
  vpc_id            = "${aws_vpc.sntxrr.id}"

  tags = "${
    map(
      "Name", "terraform-eks-sntxrr-node",
      "kubernetes.io/cluster/${var.cluster-name}", "shared",
    )
  }"
}

resource "aws_internet_gateway" "sntxrr" {
  vpc_id = "${aws_vpc.sntxrr.id}"

  tags {
    Name = "terraform-eks-sntxrr"
  }
}

resource "aws_route_table" "sntxrr" {
  vpc_id = "${aws_vpc.sntxrr.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.sntxrr.id}"
  }
}

resource "aws_route_table_association" "sntxrr" {
  count = 2

  subnet_id      = "${aws_subnet.sntxrr.*.id[count.index]}"
  route_table_id = "${aws_route_table.sntxrr.id}"
}
