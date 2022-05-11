# data "aws_iam_policy_document" "ecs" {
#   statement {
#     effect = "Allow"

#     actions = [
#       "ec2:Describe*"
#     ]

#     resources = [
#       "*"
#     ]
#   }

#   statement {
#     effect = "Allow"

#     actions = [
#       "elasticloadbalancing:DeregisterInstancesFromLoadBalancer",
#       "elasticloadbalancing:DeregisterTargets",
#       "elasticloadbalancing:Describe*",
#       "elasticloadbalancing:RegisterInstancesWithLoadBalancer",
#       "elasticloadbalancing:RegisterTargets"
#     ]

#     resources = [
#       var.alb.arn
#     ]
#   }
# }

# # data "aws_iam_policy_document" "ecs" {
# #     statement {
# #       actions = ["sts:AssumeRole"]

# #       principals {
# #           identifiers = ["ec2.amazonaws.com"]
# #           type = "Service"
# #       }
# #     }
# # }