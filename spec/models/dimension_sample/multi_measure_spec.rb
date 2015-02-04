require 'active_record_spec_helper'
require './app/models/dimension_sample/multi_measure'

RSpec.describe DimensionSample::MultiMeasure do
  describe 'columns' do
    it do
      is_expected.to have_db_column(:dataset_id).of_type(:string)
        .with_options(null: false)
    end
    it do
      is_expected.to have_db_column(:provider_id).of_type(:string)
        .with_options(null: false)
    end
    it do
      is_expected.to have_db_column(:measure_id).of_type(:string)
        .with_options(null: false)
    end
    it do
      is_expected.to have_db_column(:column_name).of_type(:string)
        .with_options(null: false)
    end
    it do
      is_expected.to have_db_column(:value).of_type(:string)
        .with_options(null: false)
    end
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:dataset_id) }
    it { is_expected.to validate_presence_of(:provider_id) }
    it { is_expected.to validate_presence_of(:measure_id) }
    it { is_expected.to validate_presence_of(:column_name) }
    it { is_expected.to validate_presence_of(:value) }
  end
end
