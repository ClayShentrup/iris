require 'reporting/downloading'
require 'reporting/downloading/manager'

module Reporting
  module Downloading
    # Get where to save the logs locally
    module GetLocalFilepathForKey
      def self.call(key)
        filename = Downloading::FILE_REGEX.match(key).to_s
        File.join(
          Reporting::Downloading::Manager::TEMP_DIRECTORY,
          filename,
        ).to_s
      end
    end
  end
end
