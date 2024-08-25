module "eks" {
    source  = "terraform-aws-modules/eks/aws"
    version = "~> 20.0"
    cluster_name = var.cluster_name
    cluster_version = var.cluster_version

    cluster_endpoint_public_access  = true

    vpc_id = module.my-vpc.vpc_id
    subnet_ids = module.my-vpc.private_subnets

    access_entries = {
        jenkins_user = {
            kubernetes_groups = []
            principal_arn     = var.creator_principal_arn

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
            principal_arn     = var.console_user_principal_arn
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