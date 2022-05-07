resource "aws_ecs_cluster" "mini_cluster" {
    lifecycle {
        create_before_destroy = true
    }
    name = "mini_ecs_cluster"
    tags = {
        name = "mini_ecs_cluster"
    }
}