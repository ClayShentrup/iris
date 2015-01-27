require 'rails_helper'
# require 'active_support/time'
require 'timecop'
# , vcr: { record: :new_episodes }
RSpec.describe Reporting::Downloading::Manager, :vcr do

  # let(:bucket_class_and_key) do
  #   {
  #     bucket_class: bucket_class,
  #     key: key,
  #   }
  # end

  # let(:bucket_class) { double('bucket class') }
  # let(:key) { 'foo/kitten.gif' }
  # let(:s3_object) { instance_double('AWS::S3::Object') }

  let(:pixel_log_path) do
    File.join(
      Reporting::Downloading::Manager::TEMP_DIRECTORY,
      'pixels.log',
    )
  end

  let(:pixel_log_data) do
    '2015-01-21T00:51:23.930728+00:00 heroku[router]: at=info method=GET ' \
    'path="/assets/pixel-5c627b14c5c52558b0568ed2a678c391.gif?data=%7B%22' \
    'event%22:%22Page%20View%22,%22properties%22:%7B%22currentUserId%22:null,' \
    '%22route%22:%22/measures_home%22,%22routeParams%22:%22%22%7D%7D' \
    '&cachebuster=5168889313936234" host=iris-acceptance-pr-45.herokuapp.com ' \
    'request_id=ade67960-ac8a-46b4-a2a1-5e0c57a38f1f fwd="216.38.151.62" ' \
    'dyno=web.1 connect=1ms service=4ms status=200 bytes=269' \
    "\n" \
    '2015-01-21T00:35:08.655741+00:00 heroku[router]: at=info method=GET '\
    'path="/assets/pixel-5c627b14c5c52558b0568ed2a678c391.gif?data=' \
    '%7B%22event%22:%22Page%20View%22,%22properties%22:%7B%22currentUserId' \
    '%22:null,%22route%22:%22/measures_home%22,%22routeParams%22:%22%22%7D%7D' \
    '&cachebuster=7676160947885364" host=iris-acceptance-pr-45.herokuapp.com ' \
    'request_id=6aed994d-6bb9-4f13-84c0-a11fd207b48f fwd="216.38.151.62" '\
    'dyno=web.1 connect=5ms service=6ms status=200 bytes=269'
  end

  let(:now_as_string) { '2015-01-26 15:45:39 -0700' }

  let(:curl_options_1) do
    { url: 'https://dabo-iris-integration-logs.s3.amazonaws.com/' \
      '03403ee6-flydata/app33381895_system/year%3D2015/month%3D01/' \
      'day%3D20/20150120-19_47_00.gz?AWSAccessKeyId=' \
      'AKIAIJ3JCEKZTE6VDZWA&Expires=1422315939&Signature=' \
      'S3HtssLWQtlzWC4nY8egofa4nKQ%3D',
      filepath: '/tmp/heroku_system_logs/20150120-19_47_00.gz' }
  end

  let(:curl_options_2) do
    { url: 'https://dabo-iris-integration-logs.s3.amazonaws.com/' \
      '03403ee6-flydata/app33381895_system/year%3D2015/month%3D01/' \
      'day%3D20/20150120-19_47_01.gz?AWSAccessKeyId=' \
      'AKIAIJ3JCEKZTE6VDZWA&Expires=1422315939&Signature=' \
      'GMvpyt%2BHXovE0WksKYypHZV61vw%3D',
      filepath: '/tmp/heroku_system_logs/20150120-19_47_01.gz' }
  end

  describe '#call' do
    it 'insert new log lines into the database' do
      allow(Reporting::Downloading::CurlLogToFile).to receive(:call)
        .with(curl_options_1) do |options|
          allow(Reporting::Downloading::WritePixelLinesToTempFile)
            .to receive(:call) do
              File.write(pixel_log_path, pixel_log_data)
            end
        end

      allow(Reporting::Downloading::CurlLogToFile).to receive(:call)
        .with(curl_options_2)


      Timecop.freeze(now_as_string) do
        subject.call
      end
    end
  end
end
