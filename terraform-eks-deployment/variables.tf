variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
}

variable "private_subnet_cidr_blocks" {
  description = "List of CIDR blocks for the private subnets"
}

variable "public_subnet_cidr_blocks" {
  description = "List of CIDR blocks for the public subnets"
}

variable "ecr_name" {
  description = "Name of the ECR repository"
}

variable "cluster_name" {
  description = "Name of the EKS cluster"
}

variable "cluster_version" {
  description = "Version of the EKS cluster"
}

variable "vpc_name" {
  description = "Name of the VPC"
}
variable "s3_terraform_bucket" {
    type = string
    description =  "Name of the S3 bucket for storing Terraform state files"
    default = "jenkins-terraform-kubernetes"
}

variable "creator_principal_arn" {
  description = "IAM user ARN who created the EKS cluster"
  type        = string
}

variable "console_user_principal_arn" {
  description = "IAM user/role ARN who has console access to the EKS cluster"
  type        = string
}