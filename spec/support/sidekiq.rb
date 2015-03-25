# More about Sidekiq testing modes:
# https://github.com/mperham/sidekiq/wiki/Testing
require 'sidekiq/testing'

RSpec.configure do |config|
  config.before(:example) do |example|
    Sidekiq::Worker.clear_all

    if example.metadata[:sidekiq] == :fake
      Sidekiq::Testing.fake!
    elsif example.metadata[:sidekiq] == :inline
      Sidekiq::Testing.inline!
    elsif example.metadata[:type] == :feature
      Sidekiq::Testing.inline!
    else
      Sidekiq::Testing.fake!
    end
  end
end
