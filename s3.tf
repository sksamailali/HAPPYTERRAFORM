resource "aws_s3_bucket" "example" {
  bucket = "happy211"
  versioning {
    enabled = true
  }

  tags = {
    Name        = "happy212"
    Environment = "Dev"
  }
}