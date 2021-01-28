resource "heroku_app" "rails_app" {
    name   = "rails-circle-demo"
    region = "tokyo" #might need to change to "us"

    buildpacks = [
        "heroku/nodejs",
        "heroku/ruby"
    ]
}

resource "heroku_addon" "rails_database" {
    app  = heroku_app.rails_app.name
    plan = "heroku-postgresql:hobby-dev"
}
