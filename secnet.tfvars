###################################
############# TF VARS #############
###################################
region                      = "us-east-1"
vpc_name                    = "SecNet Assessment VPC"
environment                 = "lower"
vpc_cidr                    = "10.10.0.0/16"
private_subnet_cidr_list    = ["10.10.1.0/24"]
public_subnet_cidr_list     = ["10.10.2.0/24"]
app_ami_id                  = "ami-9a4idniu3ndo938nloi" 
app_instance_type           = "t3.micro"
key_pair_name               = "assessment-key-pair"
app_instance_count          = "2"
app_volume_size             = "15"
vm_type                     = "t3.large"