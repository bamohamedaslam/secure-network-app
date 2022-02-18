provider "aws" {
	region = var.region
}

data "terraform_remote_state" "network" {
  backend = "s3"
  config = {
    bucket = "secnet-terraform-state"
    key    = "infra/terraform.tfstate"
    region = "us-east-1"
  }
}

