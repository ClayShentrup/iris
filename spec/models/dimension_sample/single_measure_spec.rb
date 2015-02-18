# == Schema Information
#
# Table name: dimension_sample_single_measures
#
#  id          :integer          not null, primary key
#  provider_id :string           not null
#  dataset_id  :string           not null
#  column_name :string           not null
#  value       :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'active_record_no_rails_helper'
require './app/models/dimension_sample/single_measure'
require './app/models/hospital'

RSpec.describe DimensionSample::SingleMeasure do
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
    it { is_expected.to validate_presence_of(:column_name) }
    it { is_expected.to validate_presence_of(:value) }
  end

  describe '.data' do
    let(:chart_attributes) do
      {
        dataset_id: dataset_id,
        column_name: column_name,
      }
    end
    let(:dimension_sample_attributes) do
      chart_attributes.merge(
        value: relevant_dimension_sample_1_value,
      )
    end
    let(:dataset_id) { 'ypbt-wvdk' }
    let(:column_name) { 'weighted_outcome_domain_score' }

    let!(:relevant_provider_1) do
      create(Hospital, provider_id: relevant_provider_id_1)
    end
    let(:relevant_provider_id_1) { '010001' }

    let!(:relevant_provider_2) do
      create(Hospital, provider_id: relevant_provider_id_2)
    end
    let(:relevant_provider_id_2) { '010005' }

    let!(:irrelevant_provider) do
      create(Hospital, provider_id: irrelevant_provider_id)
    end
    let(:irrelevant_provider_id) { '011998' }

    let!(:relevant_dimension_sample_1) do
      create_dimension_sample(
        provider_id: relevant_provider_id_1,
      )
    end
    let(:relevant_dimension_sample_1_value) { '7.2000000000' }

    let!(:relevant_dimension_sample_2) do
      create_dimension_sample(
        provider_id: relevant_provider_id_2,
        value: relevant_dimension_sample_2_value,
      )
    end
    let(:relevant_dimension_sample_2_value) { '12.0000000000' }

    let!(:dimension_sample_with_wrong_provider_id) do
      create_dimension_sample(provider_id: irrelevant_provider_id)
    end
    let!(:dimension_sample_with_wrong_dataset_id) do
      create_dimension_sample(dataset_id: 'bad-dataset_id')
    end
    let!(:dimension_sample_with_wrong_column_name) do
      create_dimension_sample(column_name: 'bad_column_name')
    end

    let(:providers_relation) do
      Hospital.where(
        provider_id: [relevant_provider_id_1, relevant_provider_id_2],
      )
    end

    def create_dimension_sample(custom_attributes)
      create(
        :dimension_sample_single_measure,
        dimension_sample_attributes.merge(custom_attributes),
      )
    end

    let(:data) do
      described_class.data(
        dataset_id: 'ypbt-wvdk',
        column_name: 'weighted_outcome_domain_score',
        providers_relation: providers_relation,
      )
    end

    it 'gets the data' do
      expect(data).to eq [
        relevant_dimension_sample_1_value,
        relevant_dimension_sample_2_value,
      ]
    end
  end
end
