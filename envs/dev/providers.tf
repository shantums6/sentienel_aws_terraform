terraform {
  required_version = ">= 1.0.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0" # Always pin your provider version in an enterprise!
    }
  }
}

provider "aws" {
  region = "us-east-1"

  # The Senior Trick: Default Tags
  # Every single EC2, VPC, or SQS queue created will automatically get these tags.
  default_tags {
    tags = {
      Project     = "Sentinel-Insure"
      Environment = "Dev"
      ManagedBy   = "Terraform"
    }
  }
}
