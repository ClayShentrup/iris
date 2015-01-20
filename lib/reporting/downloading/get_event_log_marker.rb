module Reporting
  module Downloading
    # Gets the event log marker
    module GetEventLogMarker
      def self.call
        $redis_pool.with do |redis|
          redis.get(SetEventLogMarker::REDIS_KEY)
        end
      end
    end
  end
end
