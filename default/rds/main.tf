# RDS - KMS key
resource "aws_kms_key" "kms_db_key" {
  description = "sjh-db-key"
}

# RDS - Secret Manager
resource "random_password" "password" {
  length		= 16
  special		= true
  override_special	= "!#$%&()*+,-./:;=?@[]^_{}"
}

# Creating a Secret for DB Master account
resource "aws_secretsmanager_secret" "sjh_db_secret" {
  name = format("%s-db-pw", var.name)
  kms_key_id	= aws_kms_key.kms_db_key.id
  depends_on	= [aws_kms_key.kms_db_key]
}

# Creating a secret versions for DB Master account
resource "aws_secretsmanager_secret_version" "sjh_db_secret_version" {
  secret_id    = aws_secretsmanager_secret.sjh_db_secret.id
  secret_string = jsonencode(
    {
      password = random_password.password.result
    }
  )
}

data "aws_secretsmanager_secret" "sjh_db_secret" {
  arn = aws_secretsmanager_secret.sjh_db_secret.arn
  depends_on = [aws_secretsmanager_secret.sjh_db_secret]
}

# Importing the AWS secret version created previously using arn.
data "aws_secretsmanager_secret_version" "sjh_db_secret_version" {
  secret_id = data.aws_secretsmanager_secret.sjh_db_secret.id
}

# After importing the secrets storing into Locals
locals {
  db_creds = jsondecode(
    data.aws_secretsmanager_secret_version.sjh_db_secret_version.secret_string
  )
}

##################################################################################
##################################################################################

resource "aws_rds_cluster_parameter_group" "sjh_parameter_group" {
  name 		 = format("%s-pg", var.name)
  family 	 = "aurora-mysql8.0"

  parameter {
    name = "server_audit_events"
    value = "CONNECT"
  }
}

# DB Subnet Group
resource "aws_db_subnet_group" "db-subnet-group" {
  name 		= format("%s-db-subnget-group", var.name)
  subnet_ids	= var.rds_subnets_ids
}

# RDS Cluster
resource "aws_rds_cluster" "aurora-mysql-db" {
  cluster_identifier		 = format("%s-db",lower(var.name))
  engine_mode			 = var.engine_mode
  db_subnet_group_name		 = aws_db_subnet_group.db-subnet-group.name
  vpc_security_group_ids	 = [var.rds_security_group_ids]
  engine			 = var.engine
  engine_version		 = var.engine_version
  availability_zones		 = var.availability_zones
  database_name			 = var.database_name
  master_username		 = var.master_username
  master_password		 = local.db_creds.password
  skip_final_snapshot		 = var.skip_final_snapshot
  
  db_cluster_parameter_group_name = aws_rds_cluster_parameter_group.sjh_parameter_group.name
  storage_encrypted = true

   lifecycle {
    ignore_changes = [master_password, availability_zones]
  }

  depends_on = [aws_rds_cluster_parameter_group.sjh_parameter_group, aws_db_subnet_group.db-subnet-group]
}


resource "aws_rds_cluster_instance" "aurora_mysql_db-instance" {
  count		= 2
  identifier 	= format("%s-db-${count.index}",var.name)
  cluster_identifier = aws_rds_cluster.aurora-mysql-db.id
  instance_class = var.instance_class
  engine	= var.engine
  engine_version = var.engine_version
  publicly_accessible = false
  apply_immediately	= false
}

