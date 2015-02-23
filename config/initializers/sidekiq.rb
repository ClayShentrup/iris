require 'sidekiq'

redis_options = {
  namespace: 'sidekiq',
}

Sidekiq.configure_client { |config| config.redis = redis_options }
Sidekiq.configure_server { |config| config.redis = redis_options }
