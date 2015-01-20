require 'rails_helper'
require 's3/get_instance'
require 'aws-sdk'

RSpec.describe Reporting::Downloading::GetS3Prefix, :vcr do
  it 'gets the prefix for the Heroku system logs saved by Flydata' do
    expect(described_class.call).to eq '3aec2e2f-flydata/app29267468_system/'
  end
end
