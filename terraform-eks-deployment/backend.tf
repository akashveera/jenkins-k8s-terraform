terraform {
  backend "s3" {
    bucket = var.s3_terraform_bucket
    region = "ap-southeast-2"
    key = "eks/terraform.tfstate"
  }
}