provider "aws" {
  region = var.aws_region
}

# S3
resource "aws_s3_bucket" "taskplanner_bucket" {
  bucket = "taskplanner.pedroalves.cloud"
}

resource "aws_s3_bucket_website_configuration" "taskplanner_bucket" {
  bucket = aws_s3_bucket.taskplanner_bucket.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "index.html"
  }
}

resource "aws_s3_bucket_ownership_controls" "taskplanner_bucket" {
  bucket = aws_s3_bucket.taskplanner_bucket.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_public_access_block" "taskplanner_bucket" {
  bucket = aws_s3_bucket.taskplanner_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_acl" "taskplanner_bucket" {
  depends_on = [
    aws_s3_bucket_ownership_controls.taskplanner_bucket,
    aws_s3_bucket_public_access_block.taskplanner_bucket,
  ]

  bucket = aws_s3_bucket.taskplanner_bucket.id
  acl    = "private"
}