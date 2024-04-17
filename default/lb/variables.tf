variable "name" {
  default = "sjh"
}

variable "public_subnet_ids" {
  description = "List of public subnet IDs"
  type        = list(string)
}
variable "security_group_id_web_sg" {}

variable "vpc_id" {}

variable "web_ids" {}

variable "acm_arn" {}

variable "acm_validation" {}
