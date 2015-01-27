require './lib/reporting/downloading/curl_log_to_file'

RSpec.describe Reporting::Downloading::CurlLogToFile do
  describe '#call' do
    let(:url) { 'http://some-url.com' }
    let(:filepath) { '/path/to/file' }
    let(:options) do
      {
        url: url,
        filepath: filepath,
      }
    end
    it 'generates the correct curl command' do
      expect(described_class).to receive(:system) do |*args|
        expect(args).to include url
        expect(args).to include filepath
      end
      described_class.call(options)
    end
  end
end
