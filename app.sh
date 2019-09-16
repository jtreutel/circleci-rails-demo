#!/bin/bash

# Initialise a new rails app - specify the rails version and we'll install the
# gem manually before invoking `rails new`.
#
# Note that the original rails gem is not stored in a volume and therefore is not
# persisted. The invocation of `bundle install` will ensure rails is
# available via bundle and should be accessed via the `./app.sh` script.
#
# Usage example: `./app.sh rails init`
#                `./app.sh rails init 5.2.3`
#                `./app.sh rails init 6 --webpack`
#
# Full args for `rails new` https://github.com/rails/rails/blob/7f16fedad32f01664ad82829f244319bc752fcd7/guides/source/command_line.md
init() {
    docker-compose run --rm rails /bin/bash -c "sudo gem install rails -v ${1:-6} && rails new . ${@:2} && bundle install"
}

# Invoke a rails command - since this uses `bundle exec`, you need to have already invoked
# the `init` function defined above to ensure that your docker setup has bundler & other gem
# dependencies installed.
# 
# Usage example: `./app.sh rails db:migrate`
rails() {
    docker-compose run --rm rails bundle exec rails "$@"
}

# Shortcut to `rake`
rake() {
    docker-compose run --rm rails bundle exec rake "$@"
}

# Shortcut to `docker-compose up` - only we ensure that there is no
# file at `tmp/server.pid`. This prevents rails complaining that a server
# is already running.
up() {
    rm tmp/pids/server.pid
    docker-compose up
}

# Shorcut for `bundle`
bundle() {
    docker-compose run --rm bundle "$@"
}

# Shortcut to access `node`
# 
# Usage example `./app.sh node --version`
node() {
    docker-compose run --rm rails node "$@"
}

# Shortcut to access `yarn`
# 
# Usage example: `./app.sh yarn --version`
yarn() {
    docker-compose run --rm rails yarn "$@" # TODO add user provided args
}

# Direct access to bash in the rails container. Assumes the container name
# is <dir>_rails_1 - this should be the case with docker-compose.
ssh() {
    docker exec -it "${PWD##*/}"_rails_1 /bin/bash
}

"$1" "${@:2}"
