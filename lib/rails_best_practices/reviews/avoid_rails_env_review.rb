module RailsBestPractices
  module Reviews
    # Reviewer class to detect usage of Rails.env
    class AvoidRailsEnvReview < Review
      interesting_nodes :call, :command_call
      interesting_files ALL_FILES

      add_callback :start_call, :start_command_call do |node|
        if node.receiver.to_s == 'Rails' &&
           node.message.to_s == 'env'

          add_error 'Avoid Rails.env in application code'
        end
      end
    end
  end
end
