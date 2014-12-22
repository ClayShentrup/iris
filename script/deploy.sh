#!/bin/sh

# Setup Github credentials
rm -f ~/.netrc
echo -e "machine github.com\n  login daboeng\n  password $GITHUB_TOKEN" >> ~/.netrc

# clone the private repo for the gem into /tmp
git clone https://github.com/dabohealth/dabo_heroku_deploy /tmp/dabo_heroku_deploy

# build the gem
cd /tmp/dabo_heroku_deploy && gem build dabo_heroku_deploy.gemspec
gem install /tmp/dabo_heroku_deploy/dabo_heroku_deploy*.gem && rbenv rehash

# Run the gem bin
heroku_deploy $1

rm -rf /tmp/dabo_heroku_deploy
