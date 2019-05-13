variable "region" {
  default = "ap-southeast-1"
}

variable "vpc_cidr" {
  default = "10.8.0.0/16"
}

variable "vpc_subnet_cidr" {
  default = "10.8.1.0/24"
}

variable "cluster_size" {
  default = 3
}

variable "ami_id" {
  default = "ami-0b419c3a4b01d1859" # Amazon Linux 2 AMI (HVM), SSD Volume Type
}

variable "ami_type" {
  default = "t2.micro"
}
