require 'vcr'

VCR.configure do |config|
  config.cassette_library_dir = 'spec/cassettes'
  config.hook_into :webmock
  config.configure_rspec_metadata!
  config.ignore_localhost = true

  # Don't change this here! Instead, to record an initial cassette,
  # do this in your spec:
  #  describe SomeThing, vcr: { record: :new_episodes }
  # Then, once the cassette is recorded, change it to this:
  #  describe Something, :vcr
  config.default_cassette_options = { record: :none }

  # Allow Code Climate gem to send test info for CI integration
  config.ignore_hosts 'codeclimate.com'
end
