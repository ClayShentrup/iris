require 'sidekiq'

redis_options = {
  url: ENV.fetch('REDIS_PROVIDER', nil),
  namespace: 'sidekiq',
}

Sidekiq.configure_client { |config| config.redis = redis_options }
Sidekiq.configure_server { |config| config.redis = redis_options }

# Hack to prevent Sidekiq from duplicate loading of explitily required
# dependencies. See https://github.com/mperham/sidekiq/issues/1791
ActiveSupport::Dependencies.mechanism = :require
