module "eks" {
    source  = "terraform-aws-modules/eks/aws"
    version = "~> 20.0"
    cluster_name = "test-eks"
    cluster_version = "1.30"

    cluster_endpoint_public_access  = true

    vpc_id = module.my-vpc.vpc_id
    subnet_ids = module.my-vpc.private_subnets

    access_entries = {
        jenkins_user = {
            kubernetes_groups = []
            principal_arn     = "arn:aws:iam::680729924294:user/jenkins-aws-terraform-user"

            policy_associations = {
                example = {
                    policy_arn = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
                    access_scope = {
                        type       = "cluster"
                    }
                }   
            }
        },
        aws_console_user = {
            kubernetes_groups = []
            principal_arn     = "arn:aws:iam::680729924294:role/AWS-486_Akash_Veerabomma_AcctAdmin"
            policy_associations = {
                example = {
                    policy_arn = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
                    access_scope = {
                        type       = "cluster"
                    }
                }   
            }
        }
    }


    tags = {
        environment = "development"
        application = "nginx-app"
    }

    eks_managed_node_groups = {
        dev = {
            min_size = 1
            max_size = 1
            desired_size = 1

            instance_types = ["t2.small"]
        }
    }
}