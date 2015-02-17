require 'reporting/downloading/get_bucket'
require 'aws-sdk'

RSpec.describe Reporting::Downloading::GetBucket do
  let(:buckets) { instance_double(AWS::S3::BucketCollection) }
  let(:bucket_name) { 'some_bucket' }
  let(:bucket_name_for_logs) { "#{bucket_name}-logs" }
  let(:bucket) { instance_double(AWS::S3::Bucket) }

  before do
    stub_const(
      'APP_CONFIG',
      double(
        aws_bucket_name: bucket_name,
      ),
    )
    allow(S3::GetBuckets).to receive(:call).and_return(buckets)
    allow(buckets).to receive(:[]).with(bucket_name_for_logs).and_return(bucket)
  end

  it 'gets the S3 bucket for this environment' do
    expect(described_class.call).to be bucket
  end
end
