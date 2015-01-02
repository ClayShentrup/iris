# Configuration as recommended by Heroku: https://devcenter.heroku.com/articles/rails-unicorn

# if Rails.application.config.development_web_server
if ENV['RACK_ENV'] == 'development'
  timeout 86_400
  # For developers using Boxen
  if ENV.fetch('BOXEN_SOCKET_DIR', nil)
    listen "#{ENV.fetch('BOXEN_SOCKET_DIR', nil)}/iris"
  end
else
  timeout 45
end

preload_app true

before_fork do |_server, _worker|
  Signal.trap 'TERM' do
    puts 'Unicorn master intercepting TERM and sending myself QUIT instead'
    Process.kill 'QUIT', Process.pid
  end

  defined?(ActiveRecord::Base) &&
    ActiveRecord::Base.connection.disconnect!
end

after_fork do |_server, _worker|
  Signal.trap 'TERM' do
    puts 'Unicorn worker intercepting TERM and doing nothing.' \
    'Wait for master to send QUIT'
  end

  defined?(ActiveRecord::Base) &&
    ActiveRecord::Base.establish_connection
end
