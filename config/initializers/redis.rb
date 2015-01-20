require 'connection_pool'
# connection pool for non-unicorn app use,
# e.g. app calls to Redis within Sidekiq workers.
$redis_pool = ConnectionPool.new(size: 1, timeout: 1) do
  Redis.new(url: ENV.fetch('REDISTOGO_URL', nil))
end
