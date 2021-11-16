terraform {
    required_providers {
        aws = {
            source = "hashicorp/aws"
            version = "~> 3.0"
        }
    }
    required_version = ">= 0.14.9"

#    backend "s3" {
#        bucket = "kubernetes"
#        key = ""
#        region = var.aws_region 
#        profile = var.profile
#    }
}

provider "aws" {
    region = var.aws_region
}

module "s3" {
    source = "./s3"
}

module "instances" {
    source = "./instances"
}
