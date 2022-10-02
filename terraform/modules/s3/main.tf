//s3 bucket
resource "aws_s3_bucket" "db" {
  bucket = "${var.name}-db-bucket"
  tags = {
    Name = var.name
  }
}
