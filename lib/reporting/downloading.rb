require 'reporting/downloading/get_file_keys'

module Reporting
  # RegEx used to find Heroku tarball log files stored on S3
  module Downloading
    FILE_REGEX = /[^\/]+\.gz\z/
  end
end
