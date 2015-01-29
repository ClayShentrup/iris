# Allows us to log messages and can be stubbed in tests
module GetLogger
  def self.info(text)
    Rails.logger.info text
  end
end
