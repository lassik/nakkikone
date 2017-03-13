#! /bin/bash -x

## clean up potential old garbage
rm -rf ./vendor/bundle/
rm -rf ./tmp/
rm .env config/{database,email,secrets}.yml

## checkout submodules
git submodule init
git submodule update

## create new configuration files
cp config/email.yml.sample config/email.yml
cp config/database.yml.sample config/database.yml
cp config/secrets.yml.sample config/secrets.yml

## create new environment file
LATEST_VERSION=`git describe --abbrev=0 --tags`
SECRETS_TOKEN=`pwgen 150 1`
KEY_BASE_TOKEN=`pwgen 150 1`

cat <<EOF > .env
## -*-conf-*-

## image configurations
VERSION=$LATEST_VERSION

## application secrets
APP_DB_DATABASE=nakkikone_production
APP_DB_USERNAME=nakki
APP_DB_PASSWORD=nakki
APP_DB_ROOTPASSWORD=nakkikone

APP_SECRET_TOKEN='$SECRETS_TOKEN'
APP_SECRET_KEY_BASE='$KEY_BASE_TOKEN'

## for deployment in non-docker environment (deprecated feature)
# export APP_SECRET_TOKEN;
# export APP_SECRET_KEY_BASE;
EOF

