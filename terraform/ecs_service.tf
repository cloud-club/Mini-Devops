resource "aws_ecs_service" "mini_ecs_service" {
    cluster = aws_ecs_cluster.mini_cluster.id
    depends_on = [ aws_iam_role_policy_attachment.ecs ]
    desired_count = 1
    enable_ecs_managed_tags = true
    force_new_deployment = true

    load_balancer {
        target_group_arn = aws_lb_target_group.mini-tg.arn
        container_name = "mini_app"
        container_port = var.container_port
    }

    name = "mini_ecs_service"
    task_definition = "${aws_ecs_task_definition.mini_task_definition.family}:${aws_ecs_task_definition.mini_task_definition_data.revision}"
}