variable "name" {
  default = "sjh"
}

variable "public_subnet_ids" {
  description = "List of public subnet IDs"
  type        = list(string)
}
variable "security_group_id_web_sg" {}

variable "vpc_id" {}

#variable "web_ids" {}

variable "acm_arn" {}

variable "acm_validation" {}

variable "web_lb_listener_port_http" {
  description	 = "Port for listener"
  default 	 = 80
}

variable "web_lb_listener_protocol_http" {
  description	 = "Protocol for listener"
  default	 = "HTTP"
}

variable "web_lb_listener_port_https" {
  description    = "Port for listener"
  default        = 443
}

variable "web_lb_listener_protocol_https" {
  description    = "Protocol for listener"
  default        = "HTTPS"
}

variable "web_lb_tg_port" {
  description	 = "Target group port"
  default	 = 80
}

variable "web_lb_tg_protocol" {
  description	 = "Target group protocol"
  default	 = "HTTP"
}

