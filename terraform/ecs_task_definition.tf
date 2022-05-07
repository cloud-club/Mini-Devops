resource "aws_ecs_task_definition" "mini_task_definition" {
    container_definitions = file("추가")
    family = "task_definition"
    memory = 500
    network_mode = "host"
}