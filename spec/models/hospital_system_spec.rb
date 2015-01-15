require 'active_record_spec_helper'
require './app/models/hospital_system'
require './app/models/hospital'

RSpec.describe HospitalSystem do
  it { should have_many(:hospitals) }

  describe 'columns' do
    specify do
      should have_db_column(:name).of_type(:string).with_options(
        null: false
      )
    end
    it { should have_db_index(:name) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
  end
end
