
variable "storage_size" {
  type        = number
  description = "The size in GB for the database"

}

variable "instance_type" {
  type        = string
  description = "The instance size to use for creating the database"

}

variable "db_password" {
  description = "The password for the database"
  type        = string

}
