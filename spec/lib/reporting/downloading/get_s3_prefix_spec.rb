require 'reporting/downloading/get_s3_prefix'

RSpec.describe Reporting::Downloading::GetS3Prefix, :vcr do
  before do
    allow(APP_CONFIG).to receive(:aws_bucket_name)
      .and_return('dabo-iris-environment-name')
    allow(APP_CONFIG).to receive(:aws_credentials)
      .and_return(
        access_key_id: '123',
        secret_access_key: 'abc',
      )
  end

  it 'gets the prefix for the Heroku system logs saved by Flydata' do
    expect(described_class.call).to eq '3aec2e2f-flydata/app29267468_system/'
  end
end
