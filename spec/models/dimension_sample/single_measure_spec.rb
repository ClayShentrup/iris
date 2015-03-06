# == Schema Information
#
# Table name: dimension_sample_single_measures
#
#  id          :integer          not null, primary key
#  socrata_provider_id :string           not null
#  dataset_id  :string           not null
#  column_name :string           not null
#  value       :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'active_record_no_rails_helper'
require './app/models/dimension_sample/single_measure'
require './app/models/provider'

RSpec.describe DimensionSample::SingleMeasure do
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
    it { is_expected.to validate_presence_of(:column_name) }
    it { is_expected.to validate_presence_of(:value) }
  end

  describe 'indexes' do
    it 'has a unique index on socrata_provider_id, column_name & dataset_id' do
      expect do
        2.times do
          create(:dimension_sample_single_measure,
                 socrata_provider_id: '102101',
                 dataset_id: '893x-ot20',
                 column_name: 'foo_bar',
          )
        end
      end.to raise_error(ActiveRecord::RecordNotUnique)
    end
  end

  describe '.data' do
    let(:chart_attributes) do
      {
        dataset_id: dataset_id,
        column_name: column_name,
      }
    end
    let(:attributes) do
      chart_attributes.merge(
        value: relevant_dimension_sample_1_value,
      )
    end
    let(:dataset_id) { 'ypbt-wvdk' }
    let(:column_name) { 'weighted_outcome_domain_score' }

    let!(:relevant_provider_1) do
      create(Provider, socrata_provider_id: relevant_provider_id_1)
    end
    let(:relevant_provider_id_1) { '010001' }

    let!(:relevant_provider_2) do
      create(Provider, socrata_provider_id: relevant_provider_id_2)
    end
    let(:relevant_provider_id_2) { '010005' }

    let!(:irrelevant_provider) do
      create(Provider, socrata_provider_id: irrelevant_provider_id)
    end
    let(:irrelevant_provider_id) { '011998' }

    let!(:relevant_dimension_sample_1) do
      create_dimension_sample(
        socrata_provider_id: relevant_provider_id_1,
      )
    end
    let(:relevant_dimension_sample_1_value) { '7.2000000000' }

    let!(:relevant_dimension_sample_2) do
      create_dimension_sample(
        socrata_provider_id: relevant_provider_id_2,
        value: relevant_dimension_sample_2_value,
      )
    end
    let(:relevant_dimension_sample_2_value) { '12.0000000000' }

    let!(:dimension_sample_with_wrong_provider_id) do
      create_dimension_sample(socrata_provider_id: irrelevant_provider_id)
    end
    let!(:dimension_sample_with_wrong_dataset_id) do
      create_dimension_sample(dataset_id: 'bad-dataset_id')
    end
    let!(:dimension_sample_with_wrong_column_name) do
      create_dimension_sample(column_name: 'bad_column_name')
    end

    let(:providers) do
      Provider.where(
        socrata_provider_id: [relevant_provider_id_1, relevant_provider_id_2],
      )
    end

    def create_dimension_sample(custom_attributes)
      create(
        :dimension_sample_single_measure,
        attributes.merge(custom_attributes),
      )
    end

    let(:data) do
      described_class.data(
        dataset_id: 'ypbt-wvdk',
        options: {
          column_name: 'weighted_outcome_domain_score',
        },
        providers: providers,
      )
    end

    it 'gets the data' do
      expect(data).to eq [
        relevant_dimension_sample_1_value,
        relevant_dimension_sample_2_value,
      ]
    end
  end

  describe '.create_or_update' do
    let(:existing_attributes) do
      {
        socrata_provider_id: socrata_provider_id,
        dataset_id: dataset_id,
        column_name: column_name,
        value: value,
      }
    end
    let(:new_attributes) do
      existing_attributes.merge(new_attribute)
    end

    let(:column_name) { 'weighted_outcome_domain_score' }
    let(:dataset_id) { 'ypbt-wvdk' }
    let(:socrata_provider_id) { '123456' }
    let(:value) { '42.42424242' }
    let!(:existing_dimension_sample) do
      create(
        :dimension_sample_single_measure,
        existing_attributes,
      )
    end
    let(:most_recent_attributes) do
      described_class.last.attributes.symbolize_keys
    end

    def create_or_update!
      described_class.create_or_update!(new_attributes)
    end

    context 'attributes match an existing record' do
      let(:new_attribute) { { value: '10.8274' } }

      it 'updates the existing record' do
        expect { create_or_update! }
          .to change { existing_dimension_sample.reload.attributes }
          .to hash_including(new_attributes.stringify_keys)
      end
    end

    context 'with a different column_name' do
      let(:new_attribute) { { column_name: 'new_outcome_domain_score_name' } }

      it 'makes a new record' do
        expect { create_or_update! }.to change(described_class, :count).by(1)
        expect(most_recent_attributes).to include new_attributes
      end
    end

    context 'with a different dataset_id' do
      let(:new_attribute) { { dataset_id: 'blah-blah' } }

      it 'makes a new record' do
        expect { create_or_update! }.to change(described_class, :count).by(1)
        expect(most_recent_attributes).to include new_attributes
      end
    end

    context 'with a different socrata_provider_id' do
      let(:new_attribute) { { socrata_provider_id: '0000002' } }

      it 'makes a new record' do
        expect { create_or_update! }.to change(described_class, :count).by(1)
        expect(most_recent_attributes).to include new_attributes
      end
    end
  end
end
