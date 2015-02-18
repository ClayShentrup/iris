require 's3/get_public_url_for_any_bucket'

RSpec.describe S3::GetPublicUrlForAnyBucket do
  let(:bucket_class_and_key) do
    {
      bucket_class: bucket_class,
      key: key,
    }
  end
  let(:bucket_class) { double('bucket class') }
  let(:key) { 'foo/kitten.gif' }
  let(:s3_object) { instance_double('AWS::S3::Object') }
  let(:expected_url_options) do
    {
      expires: Time.parse(now_as_string) + 1.hour,
      secure: true,
    }
  end
  let(:now_as_string) { '2014-09-10 15:45:39 -0700' }
  let(:url) do
    "https://mayo-act-akzeptanz.s3.amazonaws.com/#{key}?#{query}"
  end
  let(:query) do
    'AWSAccessKeyId=AKIAISKZ7ORFA57RASJA&Expires=1410392739' \
      '&Signature=I6w9YuzqwTRSYvCF9XC4C57OM1g%3D'
  end

  def actual_url
    Timecop.freeze(now_as_string) do
      described_class.call(bucket_class_and_key)
    end
  end

  before do
    allow(S3::GetObjectForAnyBucket).to receive(:call)
      .with(bucket_class_and_key).and_return(s3_object)
    allow(s3_object).to receive(:url_for).with(:get, expected_url_options)
      .and_return(URI(url))
  end

  it 'turns a key into a public URL that expires in 1 hour' do
    expect(actual_url).to eq url
  end
end
