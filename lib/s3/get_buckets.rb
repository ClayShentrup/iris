require_relative './get_instance'

module S3
  # List all buckets associated with our S3 instance/credentials.
  module GetBuckets
    def self.call
      GetInstance.call.buckets
    end
  end
end
