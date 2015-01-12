require_relative '../../lib/rails_best_practices/run_checks'

module Overcommit
  module Hook
    module PreCommit
      # Check rails best practices before commiting new code
      class RailsBestPractices < Base
        def run
          @errors = ::RailsBestPractices::RunChecks
                    .new(analyzer_options: analyzer_options)
                    .call

          @errors.any? ? [:fail, result_message] : :pass
        end

        private

        def analyzer_options
          {
            'only'   => applicable_files.map { |f| Regexp.new f },
            'silent' => true,
          }
        end

        def result_message
          @errors.join("\n")
        end
      end
    end
  end
end
