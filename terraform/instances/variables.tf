variable "k8s_type" {
  type        = string
  default     = "t2.medium"
  description = "Instance type for K8s"
}

variable "haproxy_type" {
  type        = string
  default     = "t2.micro"
  description = "Instance type for haproxy"
}

variable "ami" {
  type        = string
  default     = "ami-083654bd07b5da81d"
  description = "Instance AMI"
}

variable "block_size_k8s" {
  type        = number
  default     = 8
  description = "Block size"
}

variable "block_type_k8s" {
  type        = string
  default     = "gp2"
  description = "Block Storage type"
}

variable "block_size_haproxy" {
  type        = number
  default     = 8
  description = "Block size"
}

variable "block_type_haproxy" {
  type        = string
  default     = "gp2"
  description = "Block Storage type"
}

variable "subnet_id" {
  type        = string
  default     = "subnet-3a5ad31b"
  description = "Subnet ID"
}
