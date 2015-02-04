module Reporting
  module Downloading
    # Get the log file from AWS, save to file locally
    module CurlLogToFile
      def self.call(options)
        system('curl',
               options.fetch(:url),
               '-o',
               options.fetch(:filepath),
               '-s',
        )
      end
    end
  end
end
