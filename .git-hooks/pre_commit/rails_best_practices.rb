module Overcommit
  module Hook
    module PreCommit
      # Check rails best practices before commiting new code
      class RailsBestPractices < Base
        def run
          require 'rails_best_practices'
          require_relative '../../lib/rails_best_practices/reviews/iris_reviews'

          analyzer.analyze
          analysis_result
        end

        private

        def analysis_result
          errors_found? ? :fail : :pass
        end

        def errors_found?
          analyzer.runner.errors.any?
        end

        def analyzer
          @analyzer ||=
            ::RailsBestPractices::Analyzer.new(nil, analyzer_options)
        end

        def analyzer_options
          {
            'only'   => applicable_files.map { |f| Regexp.new f },
            'silent' => true,
          }
        end
      end
    end
  end
end
