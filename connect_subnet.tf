resource "aws_route_table_association" "sjh_test_pub_association" {
 subnet_id = aws_subnet.PUB-test_subnet.id
 route_table_id = aws_route_table.sjh_test_pub_rtb.id
}

resource "aws_route_table_association" "sjh_test_pri1_association" {
 subnet_id = aws_subnet.PRI1-test_subnet.id
 route_table_id = aws_route_table.sjh_test_pri_rtb.id
}


resource "aws_route_table_association" "sjh_test_pri2_association" {
 subnet_id = aws_subnet.PRI2-test_subnet.id
 route_table_id = aws_route_table.sjh_test_pri_rtb.id
}
