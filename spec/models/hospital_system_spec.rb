# == Schema Information
#
# Table name: hospital_systems
#
#  id   :integer          not null, primary key
#  name :string           not null
#

require 'active_record_no_rails_helper'
require './app/models/hospital_system'
require './app/models/hospital'

RSpec.describe HospitalSystem do
  it { is_expected.to have_many(:hospitals) }

  describe 'columns' do
    specify do
      is_expected.to have_db_column(:name).of_type(:string).with_options(
        null: false,
      )
    end
    it { is_expected.to have_db_index(:name) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
  end
end
