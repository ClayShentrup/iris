# See https://devcenter.heroku.com/articles/deploying-rails-applications-with-
# the-puma-web-server
unless Rails.env.test?
  Rack::Timeout.timeout = 15 # seconds
end
