resource "aws_s3_bucket" "demo" {
  bucket = var.bucket_name

  tags = {
    Name        = "Terraform Demo Bucket"
    Environment = "Learning"
    Owner       = "Ashutosh Rai"
  }
}
