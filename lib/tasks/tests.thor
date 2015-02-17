require 'English'
require 'open3'
require 'thor/rake_compat'
require './spec/support/jasmine_macros'

# Run all tests as we would on CI
class Tests < Thor
  include Thor::RakeCompat
  default_task :check

  COMMANDS = {
    'rubocop' => 'bundle exec rubocop --rails',
    'jscs' => 'bundle exec jscs .',
    'jshint' => 'bundle exec jshint .',
    'cane' => 'bundle exec cane',
    'rails_best_practices' => 'bundle exec rails_best_practices',
    'jasmine' => 'rake jasmine:ci',
    'rspec lib' => 'bundle exec rspec spec/lib',
    'rspec models' => 'bundle exec rspec spec/models',
    'rspec jobs' => 'bundle exec rspec spec/jobs',
    'rspec helpers' => 'bundle exec rspec spec/helpers',
    'rspec routing' => 'bundle exec rspec spec/routing',
    'rspec controllers' => 'bundle exec rspec spec/controllers',
    'rspec features' => 'bundle exec rspec spec/features',
  }

  desc :check, 'run all CI tasks'
  def check
    exit 1 unless results(COMMANDS).all?
  end

  desc :save_jasmine_fixtures, 'Build jasmine fixtures from rspec'
  def save_jasmine_fixtures
    `rspec -e "#{JasmineMacros::SPEC_DESCRIPTION}"`
  end

  private

  def results(commands)
    commands.values.map do |command|
      Open3.pipeline("#{command}").first.success?
    end
  end
end
