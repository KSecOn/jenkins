terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.55.0"
    }
  }
}

provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      owner      = "KSecOn"
      maneged-by = "Terraform"
    }
  }
}

terraform {
  backend "s3" {
    bucket = "bucket-backendksecon15487634"
    key    = "access/terraform.tfstate"
    region = "us-east-1"
  }
}