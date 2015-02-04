require 'active_record_spec_helper'

RSpec.describe Dimension::SingleMeasure do
  describe 'columns' do
    it { is_expected.to have_db_column(:dataset_id).of_type(:string) }
    it { is_expected.to have_db_column(:provider_id).of_type(:string) }
    it { is_expected.to have_db_column(:column_name).of_type(:string) }
    it { is_expected.to have_db_column(:value).of_type(:string) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:dataset_id) }
    it { is_expected.to validate_presence_of(:provider_id) }
    it { is_expected.to validate_presence_of(:column_name) }
    it { is_expected.to validate_presence_of(:value) }
  end
end
