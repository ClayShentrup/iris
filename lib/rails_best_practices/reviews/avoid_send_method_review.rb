module RailsBestPractices
  module Reviews
    # Reviewer class to detect usage of send method
    class AvoidSendMethodReview < Review
      interesting_nodes :call, :command_call
      interesting_files ALL_FILES

      add_callback :start_call, :start_command_call do |node|
        if node.message.to_s == 'send'
          add_error 'Avoid send method (prefer public_send instead)'
        end
      end
    end
  end
end
