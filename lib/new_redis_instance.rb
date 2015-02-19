# Create a new Redis client with the correct config
module NewRedisInstance
  def self.call
    Redis.new(url: ENV.fetch(ENV.fetch('REDIS_PROVIDER')))
  end
end
