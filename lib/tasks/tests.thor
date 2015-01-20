require 'English'
require 'open3'

# Run all tests as we would on CI
class Tests < Thor
  default_task :check

  COMMANDS = {
    'rubocop' => 'bundle exec rubocop --rails',
    'jscs' => 'bundle exec jscs .',
    'jshint' => 'bundle exec jshint .',
    'cane' => 'bundle exec cane',
    'rails_best_practices' => 'bundle exec rails_best_practices',
    'jasmine' => 'rake jasmine:ci',
    'rspec' => 'bundle exec rspec',
  }

  desc :check, 'run all CI tasks'
  def check
    exit 1 unless results.all?
  end

  private

  def results
    COMMANDS.values.map do |command|
      Open3.pipeline("bundle exec #{command}").first.success?
    end
  end
end
