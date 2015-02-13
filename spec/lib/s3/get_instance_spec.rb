require 's3/get_instance'

RSpec.describe S3::GetInstance do
  let(:s3_instance) { instance_double('AWS::S3') }
  let(:aws_credentials) { 'fake aws credentials' }

  before do
    allow(AWS::S3).to receive(:new).with(aws_credentials)
      .and_return(s3_instance)
    stub_const(
      'APP_CONFIG',
      double(aws_credentials: aws_credentials),
    )
  end

  it 'returns a new AWS::S3 instance with our credentials' do
    expect(described_class.call).to be s3_instance
  end
end
