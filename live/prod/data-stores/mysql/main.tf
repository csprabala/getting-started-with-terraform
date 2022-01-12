provider "aws" {
  region = "us-east-2"
}

module "database" {
  source = "../../../modules/data-stores/mysql"

  storage_size  = 10
  instance_type = "t2.micro"
  db_password   = var.db_password


}

terraform {
  backend "s3" {
    bucket = "cprabala-tfstate-s3-bucket"
    key    = "prod/data-stores/mysql/terraform.tfstate"
    region = "us-east-2"

    dynamodb_table = "terraform-up-and-running-locks"
    encrypt        = true
  }
}


output "address" {
  value       = module.database.address
  description = "Connect to the database at this endpoint"
}

output "port" {
  value       = module.database.port
  description = "The port database is listening on"

}
