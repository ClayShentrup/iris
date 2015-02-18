require_relative '../downloading'

module Reporting
  module Downloading
    # Get list of file keys to download
    module GetFileKeys
      class << self
        def call(keys)
          keys.select do |key|
            key =~ Downloading::FILE_REGEX
          end
        end
      end
    end
  end
end
