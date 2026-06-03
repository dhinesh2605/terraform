terraform {
  backend "s3" {
    bucket         = "icanio-terraform-storage"
    key            = "global/s3/terraform.tfstate"
    region         = "ap-south-1"
    encrypt        = true
  }
}