terraform {
  backend "s3" {

    bucket = "binbasket2022"
    region = "us-east-1"
    key = "binbasket2022/Terraform/terraform.tfstate"

    
  }
}