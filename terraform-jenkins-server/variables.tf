variable "vpc_cidr_block" {
    description = "CIDR block for the VPC"
}

variable "subnet_cidr_block" {
    description = "CIDR block for the subnet"
}

variable "availability_zone" {
    description = "Availability zone (change it according to your AWS region)"
}

variable "env_prefix" {
    description = "Prefix for tags"
}

variable "instance_type" {
    description = "EC2 instance type"
}

variable "key_name" {
    description = "EC2 key pair name that you created earlier before the start of the project"
}

variable "ssh_access_cidrs" {
    description = "List of CIDR blocks for SSH access to Jenkins server"
    type        = list(string)
    default     = ["0.0.0.0/0"] # Replace with your IP addresses in the tfvars file 
}

variable "jenkins_ui_access_cidrs" {
    description = "List of CIDR blocks for accessing Jenkins web UI"
    type        = list(string)
    default     = ["0.0.0.0/0"] # Replace with your IP addresses in the tfvars file 
}

variable "s3_terraform_bucket" {
    type = string
    description =  "Name of the S3 bucket for storing Terraform state files"
    default = "jenkins-terraform-kubernetes"
}