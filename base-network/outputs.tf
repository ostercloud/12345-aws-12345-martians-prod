output "private_subnets" {
  value = ["${aws_subnet.private_subnet.*.id}"]
}

output "public_subnets" {
  value = ["${aws_subnet.public_subnet.*.id}"]
}

output "nat_ips" {
  value = ["${aws_eip.nat_gw_eip.*.public_ip}"]
}

output "vpc_id" {
  value = "${aws_vpc.vpc.id}"
}
