variable "instance_type" {
  default = "t2.micro"
}

variable "name" {
  default = "sjh"
}

variable "public_subnet_ids" {
  description = "List of public subnet IDs"
  type        = list(string)
}

variable "private_subnet_ids" {
  description = "List of private subnet IDs"
  type        = list(string)
}
