vpc_cidr_block          = "10.0.0.0/16" # VPC address
subnet_cidr_block       = "10.0.10.0/24" # subnet address
availability_zone       = "ap-southeast-2a" # availability zone (change it according to your AWS region)
env_prefix              = "dev" # prefix for tags
instance_type           = "t2.small" # EC2 instance type
key_name                = "jenkins-server-demo" # ec2 key pair name that you created earlier before start of the project.
ssh_access_cidrs        = ["122.151.242.252/32"] # List of CIDR blocks for SSH access to Jenkins server
jenkins_ui_access_cidrs = ["122.151.242.252/32"] # List of CIDR blocks for accessing Jenkins web UI