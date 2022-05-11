resource "aws_ecs_task_definition" "mini_task_definition" {
    container_definitions = "${file("modules/ecs/container_definitions.json")}"
    family = "task_definition"
    memory = 500
    network_mode = "host"
}