module Reporting
  module Downloading
    # Set marker for event log
    module SetEventLogMarker
      REDIS_KEY = 'event_log_marker'

      def self.call(marker)
        $redis_pool.with do |redis|
          redis.set(REDIS_KEY, marker)
        end
      end
    end
  end
end
