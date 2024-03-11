variable "instance_name" {
  type = string
  default = "sjh-pub-"
}

variable "instance_type" {
  type = string
  default = "t2.micro"
}

variable "ami_id" {
  type = string
  default = "ami-0382ac14e5f06eb95"
}

variable "subnet_id" {}

