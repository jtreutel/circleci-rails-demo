resource "heroku_app" "rails_app" {
  name   = "rails-circle-demo-${random_string.random.result}"
  region = "us"

  buildpacks = [
    "heroku/nodejs",
    "heroku/ruby"
  ]
}

resource "heroku_addon" "rails_database" {
  app  = heroku_app.rails_app.name
  plan = "heroku-postgresql:hobby-dev"
}

resource "random_string" "random" {
  length  = 5
  upper   = false
  special = false
}