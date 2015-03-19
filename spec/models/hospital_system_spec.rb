# == Schema Information
#
# Table name: hospital_systems
#
#  id   :integer          not null, primary key
#  name :string           not null
#

require 'active_record_no_rails_helper'
require './app/models/hospital_system'

RSpec.describe HospitalSystem do
  it { is_expected.to have_many(:providers) }
  it { is_expected.to have_one(:account) }

  describe 'columns' do
    specify do
      is_expected.to have_db_column(:name).of_type(:string).with_options(
        null: false,
      )
    end
    it { is_expected.to have_db_index(:name) }
  end

  describe 'validations' do
    subject { build_stubbed(described_class) }

    it { is_expected.to be_valid }
    it { is_expected.to validate_presence_of(:name) }
  end

  describe '#count' do
    it do
      is_expected.to delegate_method(:providers_count)
        .to(:providers)
        .as(:count)
    end
  end
end
