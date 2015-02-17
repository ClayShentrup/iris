require 'reporting/downloading/latest_s3_key_getter'
require 's3/get_instance'
require 'aws-sdk'

RSpec.describe Reporting::Downloading::LatestS3KeyGetter, :vcr do
  let(:lazy_instance) { described_class.new(options) }
  let(:options) do
    {
      marker: marker,
    }
  end
  let(:marker) { nil }
  let(:latest_key_tracker) { {} }

  def lazily_loaded_keys
    with_vcr do
      lazy_instance.to_a
    end
  end

  def with_vcr
    VCR.use_cassette(cassette_name) { yield }
  end

  let(:expected_keys_prefix) do
    '3aec2e2f-flydata/app29267468_system/year=2014/month=09/'
  end

  let(:expected_keys) do
    %W[
      #{expected_keys_prefix}day=08/20140908-18.gz
      #{expected_keys_prefix}day=08/20140908-19.gz
      #{expected_keys_prefix}day=08/20140908-20.gz
      #{expected_keys_prefix}day=09/
      #{expected_keys_prefix}day=09/20140909-19.gz
    ]
  end
  let(:cassette_name) do
    %w[
      Reporting_Downloading_GetLatestS3Keys
      loads_the_keys_lazily
    ].join('/')
  end

  before do
    stub_const(
      'APP_CONFIG',
      double(
        aws_bucket_name: 'dabo-iris-test',
        aws_credentials: {
          access_key_id: '123',
          secret_access_key: 'abc',
        },
      ),
    )
  end

  it 'gets the full list of .gz files' do
    expect(lazily_loaded_keys).to eq expected_keys
  end

  it 'loads the keys lazily' do
    lazy_enum = lazy_instance.map { fail }
    expect do
      with_vcr { lazy_enum.force }
    end.to raise_error(RuntimeError)
  end

  context 'with a marker' do
    let(:marker_and_expected_keys_prefix) do
      '3aec2e2f-flydata/app29267468_system/year=2014/month=09/'
    end
    let(:marker) do
      "#{marker_and_expected_keys_prefix}day=09/20140909-19.gz"
    end
    let(:expected_keys) do
      %W[
        #{marker_and_expected_keys_prefix}day=10/20140910-10.gz
        #{marker_and_expected_keys_prefix}day=10/20140910-12.gz
        #{marker_and_expected_keys_prefix}day=11/20140911-11.gz
      ]
    end
    let(:cassette_name) do
      %w[
        Reporting_Downloading_GetLatestS3Keys
        with_a_marker
        continues_from_where_we_left_off
      ].join('/')
    end

    it 'continues from where we left off' do
      expect(lazily_loaded_keys).to eq expected_keys
    end
  end
end
