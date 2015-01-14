require 'active_record_spec_helper'
require './app/models/system'
require './app/models/hospital'

RSpec.describe System do
  it { should have_many(:hospitals) }

  describe 'columns' do
    it { should have_db_column(:name).of_type(:string) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name) }
  end
end
