require_relative './get_bucket'

module Reporting
  module Downloading
    # Get the S3 prefix for log files created with flydata
    module GetS3Prefix
      class << self
        FLYDATA_DIRECTORY_MATCHER = /-flydata\/\z/
        SYSTEM_LOG_MATCHER = /_system\/\z/

        def call
          system_log_branch_node.prefix
        end

        private

        def system_log_branch_node
          flydata_branch_node.children.find do |child|
            SYSTEM_LOG_MATCHER.match(child.prefix)
          end
        end

        def flydata_branch_node
          s3_bucket.as_tree.children.find do |child|
            FLYDATA_DIRECTORY_MATCHER.match(child.prefix)
          end
        end

        def s3_bucket
          Downloading::GetBucket.call
        end
      end
    end
  end
end
