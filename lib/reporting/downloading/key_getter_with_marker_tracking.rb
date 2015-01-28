require 'delegate'

module Reporting
  module Downloading
    # We fetch S3 keys in batches, using an Enumerable interface that behaves
    # similarly to an array, but lazily processes one element at a time, for
    # the sake of memory. We then want to know the last S3 key used, so we can
    # use it as a marker for future requests. This class simply tracks the last
    # key that has been evaluated.
    class KeyGetterWithMarkerTracking < SimpleDelegator
      def initialize(s3_keys_enumerator:, initial_marker:)
        @initial_marker = initial_marker
        key_getter_with_key_tracking = s3_keys_enumerator.map do |key|
          @last_key_returned = key
        end
        super(key_getter_with_key_tracking)
      end

      def marker
        @last_key_returned || @initial_marker
      end
    end
  end
end
