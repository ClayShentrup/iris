module Overcommit
  module Hook
    module PreCommit
      # Check rails best practices before commiting new code
      class RailsBestPractices < Base
        PASS_STATE = {
          true => :pass,
          false => :fail,
        }

        def run
          [status, result.stdout]
        end

        private

        def result
          @result ||= execute(%w[rails_best_practices .])
        end

        def status
          PASS_STATE.fetch(result.success?)
        end
      end
    end
  end
end
