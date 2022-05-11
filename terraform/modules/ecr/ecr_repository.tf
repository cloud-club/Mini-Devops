resource "aws_ecr_repository" "mini_ecr" {
  name = var.ecr_name

  image_scanning_configuration {
    scan_on_push = true
  }
}
