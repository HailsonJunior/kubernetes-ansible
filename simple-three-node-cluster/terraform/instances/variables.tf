variable "aws_ami" {
  description = "AWS instance AMI"
  type        = string
  default     = "ami-0fb653ca2d3203ac1"
}

variable "aws_instance_type" {
  description = "Instance type"
  type        = string
  default     = "c4.large"
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

variable "aws_vpc_id" {
  description = "My Default VPC ID"
  type        = string
  default     = "vpc-f9197592"
}
