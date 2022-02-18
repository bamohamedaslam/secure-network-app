data "aws_ami" "amazon_linux" {
	most_recent = true

	filter {
		name   = "name"
		values = ["amzn-ami*amazon-ecs-optimized"]
	}

	filter {
		name   = "architecture"
		values = ["x86_64"]
	}

	filter {
		name   = "virtualization-type"
		values = ["hvm"]
	}

	owners = ["amazon", "self"]
}

resource "aws_launch_configuration" "sample_application_server" {
	name            = "netsec_app_${var.environment}"
	image_id        = var.app_ami_id
	instance_type   = var.vm_type
	security_groups = var.security_group
	key_name        = var.key_name
	user_data       = file("${path.module}/startup.sh")

	lifecycle {
		create_before_destroy = true
	}
}

resource "aws_autoscaling_group" "sample_application_server" {
	launch_configuration 	= aws_launch_configuration.sample_application_server.name
	vpc_zone_identifier  	= var.vpc_zone_identifier
	min_size          	 	= 3
	max_size          		= 3
	target_group_arns 		= var.target_group_arns
	health_check_type 		= "ELB"
	tag {
		key                 = "Name"
		value               = "netsec_app_${var.environment}"
		propagate_at_launch = true
	}
}
