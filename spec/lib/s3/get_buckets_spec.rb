require 'aws-sdk'
require 's3/get_buckets'
require 's3/get_instance'

RSpec.describe S3::GetBuckets do
  let(:s3_instance) do
    instance_double('AWS::S3',
                    buckets: buckets,
    )
  end
  let(:buckets) { instance_double('AWS::S3::BucketCollection') }

  before do
    allow(S3::GetInstance).to receive(:call).and_return(s3_instance)
  end

  it 'gets a new instance of the S3 object' do
    expect(described_class.call).to eq buckets
  end
end
