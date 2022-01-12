provider "aws" {
  region = "us-east-2"

}

module "webserver_cluster" {
  source = "../../../modules/services/webserver-cluster"

  cluster_name           = "webservers-prod"
  db_remote_state_bucket = "cprabala-tfstate-s3-bucket"
  db_remote_state_key    = "prod/services/webserver-cluster/terraform.tfstate"


  instance_type = "t2.micro"
  min_size      = 2
  max_size      = 10

}

resource "aws_autoscaling_Schedule" "scale_out_during_business_hours" {
  scheduled_action_name = "scale-out-during-business-hours"
  min_size              = 2
  max_size              = 10
  desired_capacity      = 10
  recurrence            = "0 9 * * *"

  autoscaling_group_name = module.webserver_cluster.asg_name

}

resource "aws_autoscaling_schedule" "scale_in_at_night" {
  scheduled_action_name = "scale-in-at-night"
  min_size              = 2
  max_size              = 10
  desired_capacity      = 2
  recurrence            = "0 17 * * *"

  autoscaling_group_name = module.webserver_cluster.asg_name
}

output "alb_dns_name" {
  value       = module.webserver_cluster.alb_dns_name
  description = "The domain of the load balancer"
}



terraform {
  backend "s3" {
    bucket = "cprabala-tfstate-s3-bucket"
    key    = "prod/services/webserver-cluster/terraform.tfstate"
    region = "us-east-2"

    dynamodb_table = "terraform-up-and-running-locks"
    encrypt        = true
  }

}

