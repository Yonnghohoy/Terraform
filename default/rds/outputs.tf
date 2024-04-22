# mysql 설정 및 db연동을 위해 Endpoint를 추출한다
output "rds_writer_endpoint" {
  value = aws_rds_cluster.aurora_mysql_db.endpoint
}

