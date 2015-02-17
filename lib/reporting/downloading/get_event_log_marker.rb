require_relative 'set_event_log_marker'

module Reporting
  module Downloading
    # Gets the event log marker
    module GetEventLogMarker
      def self.call
        $redis.get(SetEventLogMarker::REDIS_KEY)
      end
    end
  end
end
