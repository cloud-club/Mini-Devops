resource "aws_launch_configuration" "mini_configuration" {
    associate_public_ip_address = true
    
    iam_instance_profile = module.iam_instance_profile.ecs.ecsInstanceProfile
    image_id = 
    instance_type = 
    key_name   = 
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

