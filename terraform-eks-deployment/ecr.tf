# Create an ECR repository
resource "aws_ecr_repository" "nginx_repo" {
  name                 = "nginx-web-server"
  image_tag_mutability = "MUTABLE"
  image_scanning_configuration {
    scan_on_push = true
  }
}

# Output the repository URL
output "ecr_repository_url" {
  value = aws_ecr_repository.nginx_repo.repository_url
}