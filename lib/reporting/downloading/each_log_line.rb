module Reporting
  module Downloading
    # A note about the performance considerations of iterating through a file in
    # Ruby!
    #
    # When you call readlines, Ruby returns an array containing the entire file.
    # When you call each_line, Ruby yields the file to your block, one line at a
    # time. We believe IO.foreach operates like each_line. The distinction may
    # become important in a future of greater log processing bandwidth.
    module EachLogLine
      def self.call(&block)
        IO.foreach(
          Reporting::Downloading::WritePixelLinesToTempFile.output_path,
          &block
        )
      end
    end
  end
end
