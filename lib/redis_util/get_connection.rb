module RedisUtil
  # Creates a new Redis connection
  class GetConnection
    class << self
      def call
        Redis.new(url: server_url)
      end

      private

      def server_url
        ENV.fetch(
          ENV.fetch('REDIS_PROVIDER'),
        )
      end
    end
  end
end
