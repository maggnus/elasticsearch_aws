variable "region" {
  default = "ap-southeast-1"
}

variable "ami_id" {
  default = "ami-0b419c3a4b01d1859" # Amazon Linux 2 AMI (HVM), SSD Volume Type
}

variable "ami_type" {
  default = "t2.micro"
}
