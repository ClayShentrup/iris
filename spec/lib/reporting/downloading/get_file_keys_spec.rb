require 'reporting/downloading'

RSpec.describe Reporting::Downloading::GetFileKeys do
  let(:key_prefix) do
    '3aec2e2f-flydata/app29267468_system/year=2014/month=09/day=08'
  end
  let(:keys) do
    %W[
      #{file_key_prefix}/20140908-18.gz
      #{file_key_prefix}/20140908-19.gz
      #{file_key_prefix}/20140908-20.gz
      #{file_key_prefix}/
    ]
  end

  let(:file_key_prefix) do
    '3aec2e2f-flydata/app29267468_system/year=2014/month=09/day=08'
  end
  let(:file_keys) do
    %W[
      #{file_key_prefix}/20140908-18.gz
      #{file_key_prefix}/20140908-19.gz
      #{file_key_prefix}/20140908-20.gz
    ]
  end

  def result
    described_class.call(keys)
  end

  it 'filters out non-file keys' do
    expect(result).to eq file_keys
  end
end
