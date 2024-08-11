terraform {
  backend "s3" {
    bucket = "akash-terraform-1"
    region = "ap-southeast-2"
    key = "eks/terraform.tfstate"
  }
}