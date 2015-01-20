module S3
  # Instantiate a new S3 object that we can interact with.
  module GetInstance
    def self.call
      AWS::S3.new(Rails.application.config.aws_credentials)
    end
  end
end
