require 'sidekiq-pro'

# Sidekiq server = worker process(es)
Sidekiq.configure_server do |config|
  config.redis = {
    url: ENV.fetch('REDISTOGO_URL', nil),
    namespace: 'sidekiq'
    # `size` is set in the SIDEKIQ_CONCURRENCY Heroku config value
  }
end

# Sidekiq client = web process(es)
# In non-dev/test environments, this is configured in config/unicorn.rb
if Rails.env.development?
  Sidekiq.configure_client do |config|
    config.redis = {
      url: ENV.fetch('REDISTOGO_URL', nil) || 'redis://localhost:6379/0',
      namespace: 'sidekiq',
    }
  end
end
