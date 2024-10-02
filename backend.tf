terraform {
  backend "s3" {
    bucket         = "aya-tf-bucket"
    key            = "terraform.tfstate"
    dynamodb_table = "state-Locks"
    region         = "us-east-1"
  }
}
# LockID