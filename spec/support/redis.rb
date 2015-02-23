require 'fakeredis/rspec'
require 'new_redis_instance'

# Facilitates testing code which uses Redis, but which
# is tested in Rails-less specs
module StubRedis
  def stub_redis
    stub_const('REDIS', Redis.new)
  end
end
