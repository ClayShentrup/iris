require 'active_record_spec_helper'
require './app/models/dimension_sample'

RSpec.describe DimensionSample do
  describe 'attributes' do
    it { is_expected.to have_db_column(:socrata_provider_id).of_type(:string) }
    it { is_expected.to have_db_column(:dimension_identifier).of_type(:string) }
    it { is_expected.to have_db_column(:value).of_type(:float) }
  end

  describe 'validations' do
    context 'no need to access the database' do
      subject { build_stubbed(described_class) }

      it { is_expected.to be_valid }

      it { is_expected.to validate_presence_of(:dimension_identifier) }
      it { is_expected.to validate_presence_of(:socrata_provider_id) }
      it { is_expected.to validate_presence_of(:value) }
    end

    it do
      is_expected.to validate_uniqueness_of(:socrata_provider_id)
        .scoped_to(:dimension_identifier)
    end
  end
end
