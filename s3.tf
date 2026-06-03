resource "aws_s3_bucket" "terraform_state" {
  bucket = "icanio-terraform-storage"
  region = "ap-south-1"
}

resource "aws_s3_bucket_versioning" "terraform_state" {
  bucket = aws_s3_bucket.terraform_state.id
  versioning_configuration {
    status = "Enabled"
  }
}