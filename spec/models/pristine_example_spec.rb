require 'active_record_spec_helper'
require './app/models/pristine_example'

RSpec.describe PristineExample do
  describe 'columns' do
    it { should have_db_column(:name).of_type(:string) }
    it { should have_db_column(:description).of_type(:text) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
  end
end
