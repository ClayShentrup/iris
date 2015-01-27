# Helper to get Rails config variables. Helpful for stubbing in tests
# so that you don't need to load Rails!
module GetConfig
  def self.call(name)
    Rails.application.config.public_send(name)
  end
end
