require 's3/get_object_for_any_bucket'
require 'active_support/core_ext/numeric/time'

# Returns a public URL for an S3 bucket from an S3 object.
module S3
  GetPublicUrlForAnyBucket = Struct.new(:options) do
    def self.call(*args)
      new(*args).call
    end

    def call
      s3_object.url_for(:get, url_options).to_s
    end

    private

    def s3_object
      GetObjectForAnyBucket.call(options.slice(:bucket_class, :key))
    end

    def url_options
      {
        expires: 1.hour.from_now,
        secure: true,
      }
    end
  end
end
