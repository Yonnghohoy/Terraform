resource "aws_vpc" "sjh_testvpc" {
 cidr_block = "10.10.0.0/16"
 enable_dns_hostnames = true
 tags = {
  Name="sjh_vpc_test2"
  }
}

