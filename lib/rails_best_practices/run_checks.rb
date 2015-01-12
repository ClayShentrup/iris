require 'rails_best_practices'
require_relative 'reviews/iris_reviews'

module RailsBestPractices
  # Run Rails Best Practices checks in Iris project
  class RunChecks < Struct.new(:options)
    def call
      analyzer.analyze
      analyzer.output if options.fetch(:show_output, false)
      analyzer.runner.errors
    end

    private

    def analyzer
      @analyzer ||=
        ::RailsBestPractices::Analyzer.new(nil, analyzer_options)
    end

    def analyzer_options
      options.fetch(:analyzer_options, {})
    end
  end
end
