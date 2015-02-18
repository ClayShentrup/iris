# Create a new Redis client with the correct config
module NewRedisInstance
  def self.call
    Redis.new(url: ENV.fetch('REDIS_PROVIDER', nil))
  end
end
