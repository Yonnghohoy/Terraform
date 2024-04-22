variable "name" {}

variable "rds_subnets_ids" {}

variable "engine_mode" {
  default = "provisioned"
}

variable "rds_security_group_ids" {}

variable "engine" {
  default = "aurora-mysql"
}

variable "engine_version" {
  default = "8.0.mysql_aurora.3.04.1"
}

variable "availability_zones" {
  type = list(string)
  default = ["ap-northeast-2a", "ap-northeast-2c"]
}

variable "database_name" {
  default = "sjh"
}

variable "master_username" {
  default = "sjh"
}

variable "skip_final_snapshot" {
  default = "true"
}

variable "instance_class" {
  default = "db.r5.large"
}

