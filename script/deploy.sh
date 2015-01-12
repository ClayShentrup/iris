#!/bin/bash

set -e

APP_NAME=$1

# Heroku toolbelt autoupdates itself and will exit a command if currently
# updating, so manually trigger an update.
if [ -z $CI ]; then
  heroku update
else
  sudo apt-get install heroku-toolbelt
fi

# Install the Heroku Pipeline Plugin, not installed by default.
heroku plugins:install git://github.com/heroku/heroku-pipeline.git

# Enable maintenance mode, promote the upstream pipeline app, run migrations
heroku maintenance:on -a $APP_NAME

if [ $APP_NAME == 'dabo-iris-integration' ]; then
  UPSTREAM_APP_NAME='iris-build-slug'
elif [ $APP_NAME == 'dabo-iris-staging' ]; then
  UPSTREAM_APP_NAME='dabo-iris-integration'
elif [ $APP_NAME == 'dabo-iris-production' ]; then
  UPSTREAM_APP_NAME='dabo-iris-staging'
else
  echo "Invalid app name."
  exit 1
fi

heroku pipeline:promote $APP_NAME -a $UPSTREAM_APP_NAME

# Reset staging db to match production
if [ $APP_NAME == 'dabo-iris-staging' ]; then
  echo "Copying production database to staging..."
  heroku pgbackups:capture -a dabo-iris-production --expire
  heroku pg:reset -a $APP_NAME DATABASE_URL --confirm $APP_NAME
  PROD_DB_URL=`heroku pgbackups:url -a dabo-iris-production`
  heroku pgbackups:restore DATABASE_URL -a $APP_NAME --confirm $APP_NAME $PROD_DB_URL
fi

echo "Running migrations..."
heroku run rake db:migrate -a $APP_NAME
echo "Restarting the app..."
heroku restart -a $APP_NAME
echo "Disabling maintenance mode!"
heroku maintenance:off -a $APP_NAME

# Notify New Relic of a release to track before/after metrics
if [ $APP_NAME == 'dabo-iris-production' ]; then
  bundle exec newrelic deployments -l $NEW_RELIC_API_KEY -a dabo-iris-production -r $REVISION -e production
fi
