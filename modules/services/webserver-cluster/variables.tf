variable "server_port" {
  description = "The port server will use for HTTP requests"
  type        = number
  default     = 8080
}

variable "cluster_name" {
  description = "The name to use for all cluster resources"
  type        = string
}

variable "db_remote_state_bucket" {
  description = "The name of the s3 bucket for database's remote state"
  type        = string
}

variable "db_remote_state_key" {
  description = "The path for the database's remote state in s3"
  type        = string
}

variable "instance_type" {
  description = "The type of EC2 instances to run (eg. t2.micro)"
  type        = string

}

variable "min_size" {
  description = "The minimum number of instances to run in the ASG"
  type        = number

}

variable "max_size" {
  description = "The maximum number of instances to run in the ASG"
  type        = number
}
