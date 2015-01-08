# Thor task to analyze code with rails_best_practices
# Execute it with `thor ruby_best_practices:check`
class RubyBestPractices < Thor
  desc 'check', 'run rails_best_practices and inform about found issues'
  def check
    require 'rails_best_practices'
    require_relative '../rails_best_practices/reviews/iris_reviews'

    analyzer = RailsBestPractices::Analyzer.new(nil)
    analyzer.analyze
    analyzer.output

    exit analyzer.runner.errors.size
  end
end
