resource "aws_s3_bucket" "k8sbucket" {
    bucket = var.bucket_name
    acl = "private"
    
    versioning {
        enabled = true
    }

    tags = {
        Name = "K8s Bucket"
    }
}