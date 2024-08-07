output "cluster_id" {
    value = module.eks.cluster_name
}

# Output the repository URL
output "ecr_repository_url" {
  value = aws_ecr_repository.nginx_repo.repository_url
}