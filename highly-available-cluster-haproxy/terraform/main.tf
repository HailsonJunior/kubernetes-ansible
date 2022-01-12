terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
  required_version = ">= 0.14.9"

  #    backend "s3" {
  #        bucket = "YOUR-BUCKET-NAME-IF-YOU-HAVE-IT"
  #        key = "FILE-NAME"
  #        region = var.aws_region 
  #    }
}

provider "aws" {
  region = var.aws_region
}

module "instances" {
  source = "./instances"
}
