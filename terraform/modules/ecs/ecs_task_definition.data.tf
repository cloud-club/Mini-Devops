data "aws_ecs_task_definition" "mini_task_definition_data"{
    task_definition = aws_ecs_task_definition.mini_task_definition.family
}