require './app/models/log_line'

module Reporting
  module Downloading
    # Save log line locally
    module StoreLogLine
      def self.call(log_line_attributes)
        LogLine.create_with(log_line_attributes)
          .find_or_create_by!(
            heroku_request_id: log_line_attributes.fetch(:heroku_request_id),
          )
      end
    end
  end
end
