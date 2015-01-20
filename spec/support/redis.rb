require 'fakeredis/rspec'

$redis_pool = ConnectionPool.new(size: 1, timeout: 1) { Redis.new }
