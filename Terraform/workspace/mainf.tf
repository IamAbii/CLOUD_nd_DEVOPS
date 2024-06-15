

module "ec2" {
  source = "./module/ec2"
    ami = var.ami
    instance_type = var.instance_type
    vpc_security_group_ids = var.vpc_security_group_ids
    subnet_id = var.subnet_id
}