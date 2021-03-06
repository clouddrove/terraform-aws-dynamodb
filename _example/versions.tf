terraform {
  required_version = ">= 0.14.11"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 3.1.15"
    }
    null = {
      source  = "hashicorp/null"
      version = ">= 2.0"
    }
  }
}
