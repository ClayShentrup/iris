module Reporting
  module Downloading
    # Filter only pixel log lines and write to temp file
    module WritePixelLinesToTempFile
      class << self
        def call
          system('bash', '-c', <<-BASH)
            gzip -q -c -d #{zipped_file_matcher} | \
            grep -e 'path="\/assets\/pixel-.*\.gif' > \
            #{output_path}
          BASH
        end

        def output_path
          File.join(
            Reporting::Downloading::Manager::TEMP_DIRECTORY,
            'pixels.log',
          )
        end

        private

        def zipped_file_matcher
          File.join(Reporting::Downloading::Manager::TEMP_DIRECTORY, '*.gz')
        end
      end
    end
  end
end
