require 'English'
require 'open3'

# Run all tests as we would on CI
class Tests < Thor
  default_task :check

  COMMANDS = {
    'rubocop' => 'rubocop --rails',
    'jscs' => 'jscs .',
    'jshint' => 'jshint .',
    'rails_best_practices' => 'rails_best_practices',
    'jasmine' => 'rake jasmine:ci',
    'rspec' => 'rspec',
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
