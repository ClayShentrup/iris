require_relative '../rails_best_practices/run_checks'

# Thor task to analyze code with rails_best_practices
# Execute it with `thor ruby_best_practices:check`
class RubyBestPractices < Thor
  desc 'check', 'run rails_best_practices and inform about found issues'
  def check
    errors = RailsBestPractices::RunChecks.new(show_output: true).call
    exit errors.empty?
  end
end
