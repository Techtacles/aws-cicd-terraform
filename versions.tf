terraform {
  backend "s3" {
    bucket = "s3://store-tfstate-files"
    key    = "terraform.tfstate"
  }
}