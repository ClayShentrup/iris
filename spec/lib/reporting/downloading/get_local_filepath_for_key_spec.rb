require 'active_record_no_rails_helper'
require 'reporting/downloading/get_local_filepath_for_key'

RSpec.describe Reporting::Downloading::GetLocalFilepathForKey do
  let(:file_key) do
    "3aec2e2f-flydata/app29267468_system/year=2014/month=09/day=08/#{filename}"
  end
  let(:filename) { '20140908-18.gz' }
  let(:expected_filepath) do
    "#{Reporting::Downloading::Manager::TEMP_DIRECTORY}/#{filename}"
  end

  it 'gives us a hash with the file name and a public URL' do
    expect(described_class.call(file_key)).to eq expected_filepath
  end
end
