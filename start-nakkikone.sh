#!/bin/sh

# remove comment to update bundles in dev env
# bundle install
# bundle update
# bundle exec rake assets:precompile

bundle exec rails s -p 3000 -b '0.0.0.0'
