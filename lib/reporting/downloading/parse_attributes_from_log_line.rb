require 'rack'

module Reporting
  module Downloading
    # Read log line and get relevant information
    class ParseAttributesFromLogLine
      TIMESTAMP_REGEX = /\A\S+/
      REQUEST_ID_REGEX = /(?<=request_id=)\S+/
      PATH_REGEX = /path="(\S+)"/

      def self.call(*args)
        new(*args).call
      end

      def initialize(log_line)
        @log_line = log_line
      end

      def call
        {
          heroku_request_id: heroku_request_id,
          logged_at: logged_at,
          data: JSON.parse(data_json),
        }
      end

      private

      def heroku_request_id
        REQUEST_ID_REGEX.match(@log_line).to_s
      end

      def logged_at
        TIMESTAMP_REGEX.match(@log_line).to_s
      end

      def data_json
        Rack::Utils.parse_query(query).fetch('data')
      end

      def query
        URI.parse(path).query
      end

      def path
        PATH_REGEX.match(@log_line).captures.first
      end
    end
  end
end
