require 's3/get_instance'
require 'aws-sdk'
require_relative 'get_s3_prefix'

module Reporting
  module Downloading
    # Returns an Enumerator::Lazy instance, which allows us to chain multiple
    # iterator blocks, but not evaluate immediately. This is a memory footprint
    # optimization.
    class LatestS3KeyGetter
      include Enumerable

      OBJECTS_PER_REQUEST = 100

      def self.new(*args)
        super.lazy
      end

      def initialize(marker:)
        @marker = marker
      end

      def each(&block)
        for_each_batch_of_s3_objects do |batch|
          lazily_loaded_keys(batch).each(&block)
        end
      end

      private

      def for_each_batch_of_s3_objects(&block)
        object_collection.each_batch(
          batch_size: OBJECTS_PER_REQUEST,
          next_token: {
            marker: @marker,
          },
          &block
        )
      end

      def object_collection
        @object_collection ||= s3_bucket.objects.with_prefix(GetS3Prefix.call)
      end

      def s3_bucket
        @s3_bucket ||= Downloading::GetBucket.call
      end

      def lazily_loaded_keys(batch)
        batch.lazy.map(&:key)
      end
    end
  end
end
