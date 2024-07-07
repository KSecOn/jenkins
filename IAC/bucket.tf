resource "aws_s3_bucket" "s3_jenkins" {
  bucket = "s3_jenkins_test"

  tags = {
    Name        = "Bucket deployment test"
    Environment = "Dev"
  }
}