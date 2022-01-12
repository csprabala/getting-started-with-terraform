resource "aws_db_instance" "example" {
  identifier_prefix = "terraform-up-and-running"
  engine            = "mysql"
  allocated_storage = var.storage_size
  instance_class    = var.instance_type
  name              = "example_database"
  username          = "admin"
  password          = var.db_password

  skip_final_snapshot = true
}
