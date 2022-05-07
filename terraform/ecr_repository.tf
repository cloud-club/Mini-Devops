resource "aws_ecr_repository" "mini_ecr" {
  name = var.app_name

  image_scanning_configuration {
    scan_on_push = true
  }
}

output "repository_url" {
    value = aws_ecr_repository.mini_ecr.repository_url
}