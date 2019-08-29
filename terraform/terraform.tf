terraform {
    backend "s3" {
        bucket = "aaron-misc"
        key    = "terraform/rails-circle-demo/"
        region = "eu-west-2"
    }
}

provider "heroku" {
    version = "~> 2.1"
}

resource "heroku_app" "rails_app" {
    name   = "rails-circle-demo"
    region = "eu"

    buildpacks = [
        "heroku/nodejs",
        "heroku/ruby"
    ]
}

resource "heroku_addon" "rails_database" {
    app  = "${heroku_app.rails_app.name}"
    plan = "heroku-postgresql:hobby-basic"
}
