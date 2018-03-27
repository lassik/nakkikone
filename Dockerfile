FROM ruby:2.2.6

MAINTAINER EntropyRy <webmaster@entropy.fi>

ENV INSTALL_PATH /srv/rails/nakkikone

ENV RAILS_ENV production

RUN apt-get update && apt-get install -qq -y --fix-missing --no-install-recommends \
    build-essential nodejs-legacy libpq-dev mysql-client

RUN mkdir -p $INSTALL_PATH

WORKDIR $INSTALL_PATH

## copy application code into working directory, ignored files and folders are listed in .dockerignore
COPY . .

## install environment application locally
RUN bundle install

## precompile assets into pipeline
RUN bundle exec rake assets:precompile

## patch problem with hardcoded image urls in vendor css
RUN cp $INSTALL_PATH/app/assets/images/glyphicons-halflings.png $INSTALL_PATH/public/assets/glyphicons-halflings.png

CMD ["bundle" "exec" "rails" "s" "-p" "3000" "-b" "0.0.0.0"]

