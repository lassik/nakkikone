FROM ruby:2.2.6

MAINTAINER EntropyRy <webmaster@entropy.fi>

ENV INSTALL_PATH /srv/rails/nakkikone

ENV RAILS_ENV production

RUN apt-get update && apt-get install -qq -y --fix-missing --no-install-recommends \
    build-essential nodejs-legacy libpq-dev mysql-client

RUN mkdir -p $INSTALL_PATH

WORKDIR $INSTALL_PATH

## initialize application environment
COPY Gemfile .

## install environment
RUN bundle install

## copy application code into working directory, ignored files and folders are listed in .dockerignore
COPY . .

## precompile assets into pipeline
RUN bundle exec rake assets:precompile

CMD ["bundle" "exec" "rails" "s" "-p" "3000" "-b" "0.0.0.0"]

