terraform {
  backend "s3" {
    bucket = "jenkins-terraform-kubernetes" # Specify the name of the S3 bucket to store the state file
    region = "ap-southeast-2"
    key = "eks/terraform.tfstate"
  }
}