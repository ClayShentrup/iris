module S3
  # Return an S3 object from a particular bucket based on the key.
  module GetObjectForAnyBucket
    def self.call(options)
      bucket = options.fetch(:bucket_class).call
      bucket.objects[
        options.fetch(:key)
      ]
    end
  end
end
