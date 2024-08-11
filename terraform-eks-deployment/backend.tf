terraform {
  backend "s3" {
    bucket = "jenkins-terraform-kubernetes"
    region = "ap-southeast-2"
    key = "eks/terraform.tfstate"
  }
}