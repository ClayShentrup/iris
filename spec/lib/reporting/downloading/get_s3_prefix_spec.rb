require 'reporting/downloading/get_s3_prefix'

RSpec.describe Reporting::Downloading::GetS3Prefix, :vcr do
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
  end

  it 'gets the prefix for the Heroku system logs saved by Flydata' do
    expect(described_class.call).to eq '3aec2e2f-flydata/app29267468_system/'
  end
end
