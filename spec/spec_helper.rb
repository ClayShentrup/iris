ENV['RAILS_ENV'] = 'test'
require 'codeclimate-test-reporter'
CodeClimate::TestReporter.start

require 'pry'
require 'support/vcr_setup'
require 'support/timecop'

RSpec.configure do |config|
  # These two settings work together to allow you to limit a spec run
  # to individual examples or groups you care about by tagging them with
  # `:focus` metadata. When nothing is tagged with `:focus`, all examples
  # get run.
  config.filter_run :focus
  config.run_all_when_everything_filtered = true

  # Many RSpec users commonly either run the entire suite or an individual
  # file, and it's useful to allow more verbose output when running an
  # individual spec file.
  if config.files_to_run.one?
    # Use the documentation formatter for detailed output,
    # unless a formatter has already been configured
    # (e.g. via a command-line flag).
    config.default_formatter = 'doc'
  end

  # Seed global randomization in this process using the `--seed` CLI option.
  # Setting this allows you to use `--seed` to deterministically reproduce
  # test failures related to randomization by passing the same `--seed` value
  # as the one that triggered the failure.
  Kernel.srand config.seed

  # rspec-expectations config goes here. You can use an alternate
  # assertion/expectation library such as wrong or the stdlib/minitest
  # assertions if you prefer.
  config.expect_with :rspec do |expectations|
    expectations.syntax = :expect
  end

  config.mock_with :rspec do |mocks|
    mocks.syntax = :expect

    # Prevents you from mocking or stubbing a method that does not exist on
    # a real object. This is generally recommended.
    mocks.verify_partial_doubles = true
  end

  config.expose_dsl_globally = false

  config.around :example, :performance do |example|
    old_perform_caching = ActionController::Base.perform_caching
    old_mechanism = ActiveSupport::Dependencies.mechanism
    old_level = Rails.logger.level

    ActionController::Base.perform_caching = true
    ActiveSupport::Dependencies.mechanism = :require
    Rails.logger.level = ActiveSupport::Logger::INFO

    example.run

    ActionController::Base.perform_caching = old_perform_caching
    ActiveSupport::Dependencies.mechanism = old_mechanism
    Rails.logger.level = old_level
  end

  config.add_setting :default_performance_runs, default: 5
  config.add_setting :performance_times, default: {
    short_time: 20,
    normal_time: 50,
    long_time: 100,
  }

  config.add_setting :fixtures_path, default: File.expand_path(
    '../fixtures', __FILE__
  )
end
