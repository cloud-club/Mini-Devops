resource "aws_launch_configuration" "mini_configuration" {
    associate_public_ip_address = true
    
    // **
    iam_instance_profile = module.iam_instance_profile.ecs.ecsInstanceProfile
    image_id = data.aws_ami.mini_ami.id
    instance_type = "t2.micro"
    key_name  = "mini-devops"
    lifecycle {
        create_before_destroy = true
    }

    name_prefix = "lauch-configuration-"
    root_block_device {
        volume_size = 30
        volume_type = "gp2"
    }


    security_groups = []
}

