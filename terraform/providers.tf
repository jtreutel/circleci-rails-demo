provider "heroku" {}

terraform {
  backend "s3" {
    profile = "circleci-custeng"
    bucket  = "jennings-test-tfstate"
    key     = "rails-circle-demo/terraform.tfstate"
    region  = "ap-northeast-1"
  }
  required_providers {
    heroku = {
      source  = "heroku/heroku"
      version = "3.2.0"
    }
  }
}