terraform {
  backend "s3" {
    bucket         = "sentinel-insure-tf-state-svh-0504" # Use your exact bucket name
    key            = "shared-services/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "sentinel-tf-state-lock" # Your DynamoDB table name
    encrypt        = true
    profile        = "shared-services"
  }
}
