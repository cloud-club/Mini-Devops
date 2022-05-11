resource "aws_ecs_service" "mini_ecs_service" {
    cluster = aws_ecs_cluster.mini_cluster.id
    depends_on = [ var.iam_role_policy_attachment ]
    desired_count = 1
    enable_ecs_managed_tags = true
    force_new_deployment = true

    load_balancer {
        target_group_arn = var.target_group.arn
        container_name = "mini_app"
        container_port = 8080
    }

    name = "mini_ecs_service"
    task_definition = "${aws_ecs_task_definition.mini_task_definition.family}:${data.aws_ecs_task_definition.mini_task_definition_data.revision}"
}