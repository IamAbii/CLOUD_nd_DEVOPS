variable "instance_type" {
  type = string
  default = "t2.micro"
}

variable "ami_id_Mumbai" {
type = string
default = "ami-0f58b397bc5c1f2e8"
}

variable "ami_id_US" {
type = string
default = "ami-09040d770ffe2224f"
}

variable "subnet_id_US" {
    type = string
    default = "subnet-0e62e341839cffa0b" 
}

variable "subnet_id_Mumbai" {
    type = string
    default = "subnet-0ae6683717320c26e" 
}

variable "is_it_a_dev_env" {
  type = bool
}