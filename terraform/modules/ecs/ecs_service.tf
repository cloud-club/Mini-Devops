# resource "aws_ecs_service" "mini_ecs_service" {
#     cluster = aws_ecs_cluster.mini_cluster.id
#     depends_on = [ var.iam_role_policy_attachment ]
#     desired_count = 1
#     enable_ecs_managed_tags = true
#     force_new_deployment = true

#     load_balancer {
#         target_group_arn = var.target_group.arn
#         container_name = "mini_app"
#         container_port = 8080
#     }

#     name = "mini_ecs_service"
#     task_definition = "${aws_ecs_task_definition.mini_task_definition.family}:${data.aws_ecs_task_definition.mini_task_definition_data.revision}"
# }


resource "aws_ecs_task_definition" "mini_ecs" {
  family = "mini_ecs"
  container_definitions = <<TASK_DEFINITION
  [
  {
    "portMappings": [
      {
        "hostPort": 8080,
        "protocol": "tcp",
        "containerPort": 8080
      }
    ],
    "cpu": 512,
    "environment": [
      {
        "name": "MINI-Devops"
      }
    ],
    "memory": 1024,
    "image": "905797561233.dkr.ecr.ap-northeast-2.amazonaws.com/mini-ecr:latest",
    "essential": true,
    "name": "mini_app"
  }
]
TASK_DEFINITION

  network_mode = "awsvpc"
  requires_compatibilities = [
    "FARGATE"]
  memory = "1024"
  cpu = "512"
  execution_role_arn = var.iam_role_policy_attachment.arn
  task_role_arn = var.iam_role_policy_attachment.arn

  tags = {
    Name = "mini_ecs"
    Project = "mini_ecs"
    Billing = "mini_ecs"
  }
}

resource "aws_ecs_service" "mini_ecs" {
  name = "mini_ecs"
  cluster = aws_ecs_cluster.mini_cluster.id
  task_definition = aws_ecs_task_definition.mini_ecs.arn
  desired_count = 1
  launch_type = "FARGATE"
  platform_version = "1.4.0"

  lifecycle {
    ignore_changes = [
      desired_count]
  }

  network_configuration {
    subnets = [
      var.ecs_subnet_a.id,
      var.ecs_subnet_b.id]
    security_groups = [
      var.ecs_sg.id]
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = var.target_group.arn
    container_name = "mini_app"
    container_port = 8080
  }
}
