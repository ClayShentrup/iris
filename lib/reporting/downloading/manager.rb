require 'fileutils'

module Reporting
  module Downloading
    # Utility to download logs from S3
    class Manager
      TEMP_DIRECTORY = '/tmp/heroku_system_logs'

      def self.call(*args)
        new(*args).call
      end

      def call
        ensure_temp_directory_exists
        download_files_with_curl
        Downloading::WritePixelLinesToTempFile.call
        insert_log_lines_into_database
      ensure
        empty_temp_directory
      end

      private

      def ensure_temp_directory_exists
        FileUtils.mkdir_p(TEMP_DIRECTORY)
      end

      def download_files_with_curl
        curl_options_array.each do |curl_options|
          Downloading::CurlLogToFile.call(curl_options)
        end
      end

      def curl_options_array
        file_keys.map do |key|
          url = S3::GetPublicUrlForAnyBucket.call(
            key: key,
            bucket_class: Reporting::Downloading::GetBucket,
          )
          {
            url: url,
            filepath: Downloading::GetLocalFilepathForKey.call(key),
          }
        end
      end

      def file_keys
        Downloading::GetFileKeys.call(key_getter_with_marker_tracking)
      end

      def key_getter_with_marker_tracking
        @key_getter_with_marker_tracking ||=
          Downloading::KeyGetterWithMarkerTracking.new(
            initial_marker: Downloading::GetEventLogMarker.call,
            s3_keys_enumerator: s3_keys_enumerator,
          )
      end

      def s3_keys_enumerator
        Downloading::LatestS3KeyGetter.new(
          marker: Downloading::GetEventLogMarker.call,
        )
      end

      def insert_log_lines_into_database
        Downloading::EachLogLine.call do |log_line|
          Downloading::StoreLogLine.call(
            Downloading::ParseAttributesFromLogLine.call(log_line),
          )
        end
        Downloading::SetEventLogMarker.call(
          key_getter_with_marker_tracking.marker,
        )
      end

      def empty_temp_directory
        FileUtils.rm_rf(TEMP_DIRECTORY)
      end
    end
  end
end
