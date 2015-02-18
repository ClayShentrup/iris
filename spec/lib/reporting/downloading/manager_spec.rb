require 'active_record_no_rails_helper'
require 'reporting/downloading/manager'
require 'support/redis'

RSpec.describe Reporting::Downloading::Manager, :vcr do
  include StubRedis

  let(:tmpdir) { Dir.mktmpdir }
  let(:gzipped_log_file_1) do
    File.join(
      tmpdir,
      curl_file_1,
    )
  end
  let(:gzipped_log_file_2) do
    File.join(
      tmpdir,
      curl_file_2,
    )
  end

  let(:curl_file_1) { '20150120-19_47_00.gz' }
  let(:curl_file_2) { '20150120-19_47_01.gz' }

  let(:expected_data_1) do
    {
      'event' => 'Page View',
      'properties' => {
        'currentUserId' => nil,
        'route' => '/measures_home',
        'routeParams' => '',
      },
    }
  end
  let(:expected_data_2) do
    {
      'event' => 'Page View',
      'properties' => {
        'currentUserId' => nil,
        'route' => '/dabo_admin',
        'routeParams' => '',
      },
    }
  end

  let(:fake_aws_credentials) do
    { access_key_id: '123', secret_access_key: 'abc' }
  end
  let(:fake_s3_object) { instance_double('AWS::S3::S3Object') }

  let(:fixture_url_1) do
    'file://' + RSpec.configuration.fixtures_path + '/reporting/' + curl_file_1
  end
  let(:fixture_url_2) do
    'file://' + RSpec.configuration.fixtures_path + '/reporting/' + curl_file_2
  end

  describe '#call' do
    let(:aws_credentials) do
      {
        access_key_id: '123',
        secret_access_key: 'abc',
      }
    end

    before do
      stub_const(
        'APP_CONFIG',
        double(
          aws_bucket_name: 'dabo-iris-environment-name',
          aws_credentials: aws_credentials,
        ),
      )
      stub_const(
        'Reporting::Downloading::Manager::TEMP_DIRECTORY',
        tmpdir,
      )
      stub_redis

      allow(S3::GetObjectForAnyBucket)
        .to receive(:call).and_return fake_s3_object
      expect(fake_s3_object).to receive(:url_for).and_return fixture_url_1
      expect(fake_s3_object).to receive(:url_for).and_return fixture_url_2

      stub_const('LOGGER', instance_double('ActiveSupport::Logger'))
      expect(LOGGER).to receive(:info).once.with(instance_of(String))

      subject.call
    end

    it 'inserts new log lines into the database' do
      expect(LogLine.all.map(&:data)).to eq [expected_data_1, expected_data_2]
    end
  end
end
