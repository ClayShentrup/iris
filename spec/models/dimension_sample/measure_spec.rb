# == Schema Information
#
# Table name: dimension_sample_measures
#
#  id                  :integer          not null, primary key
#  socrata_provider_id :string           not null
#  measure_id          :string           not null
#  value               :string           not null
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#

require 'active_record_no_rails_helper'
require './app/models/dimension_sample/measure'

RSpec.describe DimensionSample::Measure do
  describe 'columns' do
    it do
      is_expected.to have_db_column(:socrata_provider_id).of_type(:string)
        .with_options(null: false)
    end
    it do
      is_expected.to have_db_column(:measure_id).of_type(:string)
        .with_options(null: false)
    end
    it do
      is_expected.to have_db_column(:value).of_type(:string)
        .with_options(null: false)
    end
  end

  describe 'indexes' do
    it do
      is_expected.to have_db_index([:socrata_provider_id, :measure_id]).unique
    end
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:socrata_provider_id) }
    it { is_expected.to validate_presence_of(:measure_id) }
    it { is_expected.to validate_presence_of(:value) }
  end

  describe 'data methods' do
    let(:dimension_sample_attributes) do
      {
        measure_id: measure_id,
        socrata_provider_id: socrata_provider_id,
        value: value,
      }
    end

    let(:socrata_provider_id) { '010001' }
    let(:value) { '42.42424242' }
    let(:measure_id) { 'PSI_90_SAFETY' }

    describe '.data' do
      let!(:relevant_provider_1) do
        create(Provider, socrata_provider_id: relevant_provider_id_1)
      end
      let(:relevant_provider_id_1) { socrata_provider_id }

      let!(:relevant_provider_2) do
        create(Provider, socrata_provider_id: relevant_provider_id_2)
      end
      let(:relevant_provider_id_2) { '010005' }

      let(:irrelevant_provider_id) { '011998' }

      let!(:relevant_dimension_sample_1) do
        create_dimension_sample
      end
      let(:relevant_dimension_sample_1_value) { value }

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
      let!(:dimension_sample_with_wrong_measure_id) do
        create_dimension_sample(measure_id: 'HAI_1_SIR')
      end

      let(:providers) { Provider.all }

      def create_dimension_sample(**custom_attributes)
        create(
          :dimension_sample_measure,
          dimension_sample_attributes.merge(custom_attributes),
        )
      end

      let(:data) do
        described_class.data(
          measure_id: measure_id,
          providers: providers,
        )
      end

      it 'gets the data' do
        expect(data).to eq [
          [
            relevant_dimension_sample_1_value,
            relevant_provider_1.name,
          ],
          [
            relevant_dimension_sample_2_value,
            relevant_provider_2.name,
          ],
        ]
      end
    end

    describe '.create_or_update!' do
      let(:new_attributes) do
        dimension_sample_attributes.merge(new_attribute)
      end

      let!(:existing_dimension_sample) do
        create(
          :dimension_sample_measure,
          dimension_sample_attributes,
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

      context 'with a different measure_id' do
        let(:new_attribute) { { measure_id: 'HAI_1_SIR' } }

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
end
