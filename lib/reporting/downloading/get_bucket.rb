require 's3/get_buckets'
require 'get_config'

module Reporting
  module Downloading
    # Get the aws bucket for the logs
    module GetBucket
      class << self
        def call
          aws_s3_bucket_collection = S3::GetBuckets.call
          aws_s3_bucket_collection[bucket_name_for_logs]
        end

        private

        def bucket_name_for_logs
          "#{bucket_name}-logs"
        end

        def bucket_name
          GetConfig.call(:aws_bucket_name)
        end
      end
    end
  end
end
