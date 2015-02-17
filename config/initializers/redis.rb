require 'redis'

$redis = Redis.new(url: ENV.fetch('REDIS_PROVIDER', nil))
