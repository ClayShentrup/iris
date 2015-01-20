require 'rails_helper'
require 'aws-sdk'

RSpec.describe S3::GetInstance do
  let(:s3_instance) { instance_double('AWS::S3') }

  before do
    allow(AWS::S3).to receive(:new).and_return(s3_instance)
  end

  it 'returns a new AWS::S3 instance with our credentials' do
    expect(described_class.call).to eq s3_instance
  end
end
