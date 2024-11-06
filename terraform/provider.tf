terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }

    archive = {
      source = "hashicorp/data"
      version = "~> 2.6"
    }
  }
}


provider "aws" {
  region = "us-east-1"
}

provider "archive" {

}