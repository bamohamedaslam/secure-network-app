module "asg" {
	source = "./modules/asg"

	vpc_zone_identifier = data.terraform_remote_state.network.outputs.private_subnet_id_list
	app_ami_id          = var.app_ami_id
	vm_type			  	= var.vm_type
	security_group      = [aws_security_group.asg.id]
	key_name            = var.key_pair_name
	environment         = var.environment
	target_group_arns   = [module.alb.alb_tg_arn]
}

module "alb" {
	source = "./modules/lb"

	alb_subnets           = data.terraform_remote_state.network.outputs.public_subnet_id_list
	alb_security_grps     = [aws_security_group.alb.id]
	alb_listener_port     = "80"
	alb_listener_protocol = "HTTP"
	idle_timeout          = "4000"
	vpc_id                = data.terraform_remote_state.network.outputs.vpc_id
	target_group_sticky   = "false"
	target_group_port     = "1234"
	target_group_path     = "/index.html"
	environment           = var.environment
	alb_path              = ["/"]
	svc_port              = "1234"
}
