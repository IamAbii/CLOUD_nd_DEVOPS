provider "aws" {
    alias = "us"
    region = "us-east-2"  
}

provider "aws" {
    alias = "mumbai"
    region = "ap-south-1"  
}


resource "aws_instance" "us" {
    count = var.is_it_a_dev_env == true ? 1 : 0
    ami = var.ami_id_US
    instance_type = var.instance_type
    subnet_id = var.subnet_id_US
    key_name = "US_ES2"
    
    provider = aws.us
    
    tags = {
      Name = "DEV_ENV_SERVER"
    }
}

resource "aws_instance" "Mumbai" { 

    count = var.is_it_a_dev_env == false ? 2 : 0
    ami = var.ami_id_Mumbai
    instance_type = var.instance_type
    subnet_id = var.subnet_id_Mumbai
    key_name = "Mumbai_key"
    provider = aws.mumbai
    
    tags = {
      Name = "PROD_SERVER"
    }
}
