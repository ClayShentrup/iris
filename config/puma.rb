# See: https://devcenter.heroku.com/articles/deploying-rails-applications-with-
# the-puma-web-server
workers Integer(ENV.fetch('WEB_CONCURRENCY', 2))

if ENV['RACK_ENV'] == 'development'
  # bind to socket for nginx - http://iris.dev
  if ENV.fetch('BOXEN_SOCKET_DIR', nil)
    bind "unix:#{ENV.fetch('BOXEN_SOCKET_DIR', nil)}/iris"
  end
end

# PER HEROKU:
# Puma allows you to configure your thread pool with a min and max setting,
# controlling the number of threads each Puma instance uses. The min threads
# allows your application to spin down resources when not under load. This
# feature is not needed on Heroku as your application can consume all of the
# resources on a given dyno. We recommend setting min to equal max.
threads_count = Integer(ENV.fetch('MAX_THREADS', 4))
threads(threads_count, threads_count)

preload_app!

port ENV.fetch('PORT', 3000)
environment ENV.fetch('RACK_ENV', 'development')

on_worker_boot do
  # Worker specific setup for Rails 4.1+
  # See: https://devcenter.heroku.com/articles/deploying-rails-applications-with
  # -the-puma-web-server#on-worker-boot
  ActiveRecord::Base.establish_connection
end
