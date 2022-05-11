output "repository_url" {
    value = aws_ecr_repository.mini_ecr.repository_url
}

output "ecr" {
  value = aws_ecr_repository.mini_ecr
}