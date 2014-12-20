# See https://devcenter.heroku.com/articles/rails-unicorn
if Rails.env.development? || Rails.env.test?
  Rack::Timeout.timeout = 1.day.seconds
else
  Rack::Timeout.timeout = 10  # seconds
end
