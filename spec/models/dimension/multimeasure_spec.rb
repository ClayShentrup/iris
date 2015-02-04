require 'rails_helper'

RSpec.describe Dimension::Multimeasure do
  describe 'columns' do
    it { is_expected.to have_db_column(:provider_id).of_type(:string) }
    it { is_expected.to have_db_column(:measure_id).of_type(:string) }
    it { is_expected.to have_db_column(:column_name).of_type(:string) }
    it { is_expected.to have_db_column(:value).of_type(:string) }
  end

  describe 'indexes' do
    it { is_expected.to have_db_index(:provider_id) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:provider_id) }
    it { is_expected.to validate_presence_of(:measure_id) }
    it { is_expected.to validate_presence_of(:column_name) }
    it { is_expected.to validate_presence_of(:value) }
  end
end
