terraform {
  required_version = "~> 1.0" 
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
  cloud {
   organization = "yo_kash_project"

   workspaces {
     name = "yo_kash_project_fresh"
   }
  }
}


provider "aws" {
  region = "us-east-1"                  #Set our desired AWS Region
}