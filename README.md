# Iris #

Improving the Quality of Care, one Metric at a Time.

| Build | Status | Code Quality | Test Coverage |
| ----- | ------ | ------------ | ---------- |
| Acceptance | [![Build Status](https://semaphoreapp.com/api/v1/projects/9342b471-18bc-4ab5-a15c-b81cbf364417/313354/badge.png)](https://semaphoreapp.com/dabohealth/iris) | [![Code Climate](https://codeclimate.com/repos/5473af9369568066690132ad/badges/49bcf5b3eb3e945a25f0/gpa.svg)](https://codeclimate.com/repos/5473af9369568066690132ad/feed) | [![Code Climate](https://codeclimate.com/repos/5473af9369568066690132ad/badges/49bcf5b3eb3e945a25f0/gpa.svg)](https://codeclimate.com/repos/5473af9369568066690132ad/feed) |

## Setup ##

<em>How do I, as a developer, start working on the project?</em>

Ruby version is specified in `.ruby-version`. Recent versions of rbenv will detect it automatically.

### Boxen ###
This project requires Dabo's development provisioning system, Boxen. Go [here](https://github.com/dabohealth/dabo-boxen) to setup Boxen.

After setting up Boxen, you can use boxen to clone and setup the `Iris` project automatically in `~/src/iris` by running:

    $ boxen iris

Boxen will:

* Ensure Postgresql is installed and running
* Install project version of Ruby and automatically run `bundle install`
* Install required npm packages (jshint, jscs) by running `npm install`
* Prepare development and test databases as well as default config/database.yml
* Setup nginx/dnsmasq so you can access the development server at `http://iris.dev/`

### Starting the development server ###

1. `foreman start`
  * To start the web server only: `foreman start web`
  * To start the Sidekiq server only: `foreman start worker`

2. `open http://iris.dev/` (or `open http://localhost:3000`)

### Heroku ###
Heroku access is needed for loading realistic data from integration, staging, and production environments, as well as deploying to any of these environments.

1. Obtain `eng-service@dabohealth.com` Heroku credentials from Passpack.
2. Login from the command line: `heroku login`
3. Add the Heroku repos: `for x in integration staging production; do git remote add ${x} git@heroku.com:iris-${x}.git; done`

### Binaries and Binstubs ###
In Rails 4, binaries (`rails`, `rake`, `rspec`) now live in `bin/`. You no longer need to prefix these commands with `bundle exec`. Instead, add `bin` to your `PATH` environment variable:

    # ~/.profile
    export PATH=bin:$PATH

## Testing ##

Iris uses [RSpec](http://rspec.info/) for ruby tests and [Jasmine](http://jasmine.github.io/) for JavaScript tests.

- `rspec` will run all ruby specs.
- `rake jasmine` will start the Jasmine server. Point your browser to `localhost:8888` to run all javascript specs in the browser. The suite will run every time this page is re-loaded.
- `rake jasmine:ci` will run Jasmine specs on the command line without the need for a browser.

### Javascript Fixtures ###
In your controllers specs, wrap any command that gets a response (like get :show) in
`save_fixtures do`. This will generate an html file in
`spec/javascripts/features/`.

Alternatively, you can add `save_fixtures` to the bottom of a test that calls
`get` and it will save the response body as the fixture. However, this method
will not stub out the user id and user email in the headers and footers,
meaning the fixture could change each time controller specs are run.

Then in your jasmine specs, use `loadFixtures('the-generated-file.html')`
in a beforeEach to have it available in the `#body` div.

If you are testing features that are hiding behind a feature flip, you will
need to run `enable_feature :feature_name` inside the `save_fixture` block
to get it in the generated fixture.

### Continuous Integration ###

Tests are run on each branch on GitHub via [Semaphore](https://semaphoreapp.com/)

Any branch that passes CI and has an open pull request will have a Heroku instance created modeled after `iris-acceptance`, available at `http://iris-acceptance-[pr_id].herokuapp.com`

### Browser Testing ###

Feature tests are run in Chrome via Selenium. The Semaphore CI platform also runs feature specs in Selenium Chrome.

## Deploying ##

Iris is deployed to Heroku. CI will automatically deploy passing builds to the Heroku apps below:

| branch     | app | site |
| ---------- | --- | ---- |
| master     | [iris-integration](https://dashboard.heroku.com/apps/iris-integration/resources) | [iris-integration.herokuapp.com](https://iris-integration.herokuapp.com/) |
| staging    | [iris-staging](https://dashboard.heroku.com/apps/iris-staging/resources) | [iris-staging.herokuapp.com](https://iris-staging.herokuapp.com/) |
| production | [iris-production](https://dashboard.heroku.com/apps/iris-production/resources) | [iris.dabohealth.com](https://iris.dabohealth.com/) |
| feature branches | iris-acceptance-[your-pr-id] | e.g [iris-acceptance-1234567](https://iris-acceptance-1234567.herokuapp.com)

A procedural shell script manages the deploys to Heroku by using Heroku's pipelines to compile a slug once and promote that slug downstream to each successive environment app. The deploy process is outlined in the graphic below.

![deploy process - new page](https://cloud.githubusercontent.com/assets/3607358/5651089/43512dea-9659-11e4-84fd-aa30ef1f58bc.png)

* The CI deploys code to **`iris-build-slug`** after code is pushed to Master and all tests pass.

* **Integration** has all the code that will be included in the next release. It is where code is merged to Master. Continuous Integration tests must pass before deployment. Data is refreshed as needed. During deployment, `integration` will enter maintenance mode, promote `iris-build-slug` and run migrations.

* **Staging** is used as a production deploy test, or *production practice*. Data is always refreshed before deployment. During deployment, `staging` will enter maintenance mode, copy data from the production database, promote `integration` and run migrations.

* **Production** is the only place where users (Dabo staff or customers) access our systems. This is the only environment in which the deploy process is **started by a human**. The on-call engineer (described below in "[Deployment Schedule](https://github.com/dabohealth/iris#deployment-schedule)") will manually deploy code to `production` from the CI.

Integration and Staging applications use sanitized data from production (real metric samples and other data, but all personal information scrubbed).

Migrations are run regardless of whether there are new migrations or not.

### Acceptance/Feature Apps ###

Temporary "acceptance" apps are created upon opening a pull request for a feature branch. After the pull request is closed, the acceptance app is automatically spun down. See our [acceptance app manager] (https://github.com/dabohealth/acceptance-app-manager#acceptance-app-manager) for details.

### Deployment Schedule ###
Continuous deployment of bug fixes and performance improvements take place Monday–Thursday (never Friday or weekends/holidays). For every production release, an engineer is responsible for deployment and will be on-call until the next release. Additionally, the on-call engineer from the previous deployment will serve as backup on-call.

A [feature flipping gem] (https://github.com/dabohealth/iris#feature-flipping) manages feature deployment. Features can be enabled at a certain time and for certain clients.

### Database Backups ###

Heroku provides scheduled database backups. For a list of available backups for that Heroku environment, run:

    heroku pgbackups -a iris-[integration|staging|production]

See [https://devcenter.heroku.com/articles/pgbackups](https://devcenter.heroku.com/articles/pgbackups) for details.

### Error reporting ###

Errors are sent to [Airbrake](https://dabo.airbrake.io).

### Analytics ###

#### Event Logging ####
[See Reporting Readme Here](lib/reporting/README.md)

### Performance monitoring ###

New Relic is included in the project in development and via Heroku environments. To see metrics on recent requests in **development** run:

* `open http://iris.dev/newrelic` or (`open http://localhost:3000/newrelic`)

In production, use the Heroku web resource link to browse to the New Relic dashboard for the app.

### Environment variables ###

Treat `.env` like a schema for environment keys. Those needed to run the app in development mode should be set already. Blank entries are not needed in development mode but are used in at least one of the production environments (where they are set via `heroku config`).

## Code style and quality ##

### Javascript ###

- Javascript code quality is ensured by two npm packages: JsHint and JSCS. They will run automatically as a pre-commit hooks.

### Ruby ###
[Rubocop](https://github.com/bbatsov/rubocop) is configured in `.rubocop.yml` to enforce code quality and style standards based on the [Ruby Style Guide](https://github.com/bbatsov/ruby-style-guide) and runs every time you commit using a pre-commit hook.

To identify and have Rubocop automatically correct violations when possible, run:

* `rubocop -a [path_to_file]` for individual files
* `rubocop -a` for all Ruby files

## Engineering Workflow Overview ##

Dabo's current engineering workflow has been fully documented and can be found [here](https://docs.google.com/a/dabohealth.com/document/d/1zMa4PofvjA9LJna0EZgz5Ob_vSlc7H0KP0LkRnt1neM/edit).

## Contributing changes ##

### Feature Flipping ###

Features can be enabled or disabled using the [Flip](https://github.com/pda/flip) gem. The gem provides a dashboard, found at `/flip`, where a feature can be actived using one of the following strategies:

- default (Allows all features to be enabled/disabled by default. Feature defaults will override this value.)
- database (To flip features site-wide for all users.)
- cookie (To flip features just for you.)

#### Enabling features ####
1. Declare feature in `app/models/feature.rb`

```ruby
feature :example, #choose a name for your feature
        default: false, #disables by default
        description: 'An Example'
```

2. Use `feature? :feature_name` to restrict/allow access to a feature in the view.

```haml

- if feature? :example
  %h1 This will be shown if the feature is enabled!

- else
  %h1 Otherwise this will be shown!
```

The project backlog is in [Pivotal Tracker](https://www.pivotaltracker.com/n/projects/1177736).
