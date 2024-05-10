variable "vpc_cidr_block" {
  default = "10.0.0.0/16"
}

variable "name" {
  default = "sjh"
}

variable "public_subnets" {
  type = map
  default = {
    pub-sub-1 = {
      az = "ap-northeast-2a"
      cidr = "10.0.0.0/24"
    }
    pub-sub-2 = {
      az = "ap-northeast-2c"
      cidr = "10.0.1.0/24"
    }
  }
}
