terraform {
  backend "s3" {

    bucket = "binbasket2022"
    region = "us-east-1"
    key    = "Terraform/prov/terraform.tfstate"


  }
}