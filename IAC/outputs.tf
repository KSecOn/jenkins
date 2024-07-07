output "vpc_id" {
  value = aws_vpc.jenkins_vpc.id
}

output "subnet_id" {
  value = aws_subnet.jenkins_subnet.id
}

output "gateway_id" {
  value = aws_vpn_gateway.jenkins_vpn_gw.id
}

output "route_table_id" {
  value = aws_route_table.jenkins_route.id
}