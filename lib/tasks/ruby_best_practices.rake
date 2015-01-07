namespace :ruby_best_practices do
  desc "run rails_best_practices and inform about found issues"
  task :check do
    require 'rails_best_practices'
    require 'rails_best_practices/reviews/iris_reviews'

    app_root = Rake.application.original_dir
    analyzer = RailsBestPractices::Analyzer.new(app_root)
    analyzer.analyze
    analyzer.output
    fail 'Found bad practices' if analyzer.runner.errors.size > 0
  end
end
