# Revisit checking in Airbrake's Api key. It may not be the best idea to
# save it here.

if Rails.env.production?
  Airbrake.configure do |config|
    config.api_key = '809f1ae85c2e20f5480863f674243cd1'
  end
end
