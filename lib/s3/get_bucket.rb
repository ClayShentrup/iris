require 's3/get_buckets'

module S3
  # Get the bucket based on the Rails environment and project name.
  module GetBucket
    def self.call
      GetBuckets.call[
        APP_CONFIG.aws_bucket_name
      ]
    end
  end
end
