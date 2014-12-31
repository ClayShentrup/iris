# Iris #

Improving the Quality of Care, one Metric at a Time.

| Build | Status | Code Quality | Test Coverage |
| ----- | ------ | ------------ | ---------- |
| Acceptance | [![Build Status](https://semaphoreapp.com/api/v1/projects/9342b471-18bc-4ab5-a15c-b81cbf364417/313354/badge.png)](https://semaphoreapp.com/dabohealth/comparitron) | [![Code Climate](https://codeclimate.com/repos/5473af9369568066690132ad/badges/49bcf5b3eb3e945a25f0/gpa.svg)](https://codeclimate.com/repos/5473af9369568066690132ad/feed) | [![Code Climate](https://codeclimate.com/repos/5473af9369568066690132ad/badges/49bcf5b3eb3e945a25f0/gpa.svg)](https://codeclimate.com/repos/5473af9369568066690132ad/feed) |

## Setup ##

<em>How do I, as a developer, start working on the project?</em>

Ruby version is specified in `.ruby-version`. Recent versions of rbenv will detect it automatically.

### Boxen ###
This project requires Dabo's development provisioning system, Boxen. Go [here](https://github.com/dabohealth/dabo-boxen) to setup Boxen.

After setting up Boxen, you can use boxen to clone and setup the `Iris` project automatically in `~/src/iris` by running:

`$ boxen iris`

Boxen will:

* Ensure Postgresql is installed and running
* Install project version of Ruby and automatically run `bundle install`
* Prepare development and test databases as well as default config/database.yml
* Setup nginx/dnsmasq so you can access the development server at `http://iris.dev/`

### Starting the development server ###

1. `foreman start`
2. `open http://localhost:3000`
  * If using Boxen, you can access the development server with `open http://iris.dev/`

- To start the web server only: `foreman start web`
- To start the Sidekiq server only: `foreman start worker`

### Heroku ###
Heroku access is needed for loading realistic data from acceptance, staging, and production environments, as well as deploying to any of these environments.

1. Obtain `eng-service@dabohealth.com` Heroku credentials from Passpack.
2. Login from the command line: `heroku login`
4. Add the Heroku repos: `for x in acceptance staging production; do git remote add ${x} git@heroku.com:iris-${x}.git; done`

### Binaries and Binstubs ###
In Rails 4, binaries (`rails`, `rake`, `rspec`) now live in bin/. You no longer need to prefix these commands with `bundle exec`. Instead, add `bin` to your `PATH` environment variable:

    # ~/.profile
    export PATH=bin:$PATH

## Testing ##

Iris uses [RSpec](http://rspec.info/) for ruby tests and [Jasmine](http://jasmine.github.io/) for JavaScript tests.

- `rspec` will run all ruby specs.
- `rake jasmine` will start the Jasmine server. Point your browser to `localhost:8888` to run all javascript specs in the browser. The suite will run every time this page is re-loaded.

### Continuous Integration ###

Tests are run on each branch on GitHub via [https://semaphoreapp.com/](https://semaphoreapp.com/)

Any branch that passes CI and has an open pull request will have a Heroku instance created modeled after `iris-acceptance`, available at `http://iris-acceptance-[pr_id].herokuapp.com`

### Browser Testing ###

Feature tests are run in Chrome via Selenium. The Semaphore CI platform also runs feature specs in Selenium Chrome.

## Deploying ##

Iris is deployed to Heroku. Semaphore will automatically deploy passing builds to the Heroku apps below:

| branch     | app | site |
| ---------- | --- | ---- |
| master     | [iris-acceptance](https://dashboard.heroku.com/apps/iris-acceptance/resources) | [iris-acceptance.herokuapp.com](https://iris-acceptance.herokuapp.com/) |
| staging    | [iris-staging](https://dashboard.heroku.com/apps/iris-staging/resources) | [iris-staging.herokuapp.com](https://iris-staging.herokuapp.com/) |
| production | [iris-production](https://dashboard.heroku.com/apps/iris-production/resources) | [iris.dabohealth.com](https://iris.dabohealth.com/) |
| feature branches | iris-acceptance-[your-pr-id] | e.g [iris-acceptance-1234567](https://iris-acceptance-1234567.herokuapp.com)

Acceptance has all the code that will be included in the next release.
Staging is used as a production deploy test.

Acceptance and Staging applications use sanitized data from production (real metric samples and other data, but all personal information scrubbed).

### Database Backups ###

Heroku provides scheduled database backups. Run `heroku pgbackups -a iris-[Acceptance|Staging|Production]` for a list of available backups for that Heroku environment. See [https://devcenter.heroku.com/articles/pgbackups](https://devcenter.heroku.com/articles/pgbackups) for details.

### Error reporting ###

Errors are sent to [https://dabo.airbrake.io](https://dabo.airbrake.io)

### Analytics ###

- TBD

### Performance monitoring ###

New Relic is included in the project in development and via Heroku environments.
In development `open http://localhost:3000/newrelic` (`open http://comparitron.dev/newrelic` if using Boxen) to see metrics on recent requests.
In acceptance/production use the Heroku web resource link to browse to the New Relic dashboard for the app.

### Environment variables ###

Treat `.env` like a schema for enviornment keys. Those needed to run the app in development mode should be set already. Blank entries are not needed in development mode but are used in at least one of the production environments (where they are set via `heroku config`).

### Code style and quality ###

#### Javascript ####

- TBD

#### Ruby ####
[Rubocop](https://github.com/bbatsov/rubocop) is configured in `.rubocop.yml` to enforce code quality and style standards based on the [Ruby Style Guide](https://github.com/bbatsov/ruby-style-guide) and runs every time you commit using a pre-commit hook.

`rubocop -a [path_to_file]` will identify and attempt to automatically correct violations when possible.

## Contributing changes ##

The project backlog is in [Pivotal Tracker](https://www.pivotaltracker.com/n/projects/1177736).

### Engineering Workflow Overview ###

Dabo's current engineering workflow has been fully documented and can be found [here](https://docs.google.com/a/dabohealth.com/document/d/1zMa4PofvjA9LJna0EZgz5Ob_vSlc7H0KP0LkRnt1neM/edit).
