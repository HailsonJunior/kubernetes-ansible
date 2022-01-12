variable "aws_ami" {
  description = "AWS instance AMI"
  type        = string
  default     = "ami-04505e74c0741db8d"
}

variable "aws_instance_type" {
  description = "Instance type"
  type        = string
  default     = "c3.large"
}

variable "aws_root_ebs_size" {
  description = "EBS block storage size"
  type        = number
  default     = 8
}

variable "aws_root_ebs_type" {
  description = "EBS block storage type"
  type        = string
  default     = "gp2"
}
