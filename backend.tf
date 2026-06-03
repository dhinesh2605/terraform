terraform {
  backend "s3" {
    bucket         = "icanio-terraform-storage"
    key            = "global/s3/terraform.tfstate"
    region         = "ap-south-1"
    encrypt        = true
    use_lock_file  = true  # Native S3 state locking available in Terraform 1.10+
  }
}