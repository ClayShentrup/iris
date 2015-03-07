# == Schema Information
#
# Table name: dimension_sample_multi_measures
#
#  id                  :integer          not null, primary key
#  socrata_provider_id :string           not null
#  measure_id          :string           not null
#  column_name         :string           not null
#  value               :string           not null
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  dataset_id          :string           not null
#

require 'active_record_no_rails_helper'
require './app/models/dimension_sample/multi_measure'

RSpec.describe DimensionSample::MultiMeasure do
  describe 'columns' do
    it do
      is_expected.to have_db_column(:dataset_id).of_type(:string)
        .with_options(null: false)
    end
    it do
      is_expected.to have_db_column(:socrata_provider_id).of_type(:string)
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
    it { is_expected.to validate_presence_of(:socrata_provider_id) }
    it { is_expected.to validate_presence_of(:measure_id) }
    it { is_expected.to validate_presence_of(:column_name) }
    it { is_expected.to validate_presence_of(:value) }
  end
end
