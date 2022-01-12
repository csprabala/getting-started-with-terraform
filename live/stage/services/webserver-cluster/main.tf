provider "aws" {
  region = "us-east-2"

}

module "webserver_cluster" {
  source = "../../../modules/services/webserver-cluster"

  cluster_name           = "webservers-stage"
  db_remote_state_bucket = "cprabala-tfstate-s3-bucket"
  db_remote_state_key    = "stage/data-stores/mysql/terraform.tfstate"

  instance_type = "t2.micro"
  min_size      = 2
  max_size      = 2

}

resource "aws_security_group_rule" "allow_testing_inbound" {

  type              = "ingress"
  security_group_id = module.webserver_cluster.alb_security_group_id

  from_port   = 12345
  to_port     = 12345
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]

}

output "alb_dns_name" {
  value       = module.webserver_cluster.alb_dns_name
  description = "The domain of the load balancer"
}

terraform {
  backend "s3" {
    bucket = "cprabala-tfstate-s3-bucket"
    key    = "stage/services/webserver-cluster/terraform.tfstate"
    region = "us-east-2"

    dynamodb_table = "terraform-up-and-running-locks"
    encrypt        = true
  }

}
