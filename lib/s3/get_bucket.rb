module S3
  # Get the bucket based on the Rails environment and project name.
  module GetBucket
    def self.call
      GetBuckets.call[
        Rails.application.config.aws_bucket_name
      ]
    end
  end
end
