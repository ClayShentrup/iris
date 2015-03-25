module RuboCop
  module Cop
    # Rule to prevent these from being used
    class TodoOffense < Cop
      MSG = 'Add a task or chore instead of using TODO'
      def investigate(processed_source)
        processed_source.comments.each do |comment|
          next unless comment.text.include?('TODO')
          add_offense(comment, :expression)
        end
      end
    end
  end
end
