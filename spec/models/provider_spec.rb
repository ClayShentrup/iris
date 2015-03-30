# == Schema Information
#
# Table name: providers
#
#  id                  :integer          not null, primary key
#  name                :string           not null
#  zip_code            :string           not null
#  hospital_type       :string           not null
#  socrata_provider_id :string           not null
#  state               :string           not null
#  city                :string           not null
#  hospital_system_id  :integer
#

require 'active_record_no_rails_helper'
require './app/models/provider'

RSpec.describe Provider do
  describe 'columns' do
    it do
      is_expected.to have_db_column(:name).of_type(:string)
        .with_options(null: false)
    end
    it do
      is_expected.to have_db_column(:zip_code).of_type(:string)
        .with_options(null: false)
    end
    it do
      is_expected.to have_db_column(:hospital_type).of_type(:string)
        .with_options(null: false)
    end
    it do
      is_expected.to have_db_column(:socrata_provider_id).of_type(:string)
        .with_options(null: false)
    end
    it do
      is_expected.to have_db_column(:state).of_type(:string)
        .with_options(null: false)
    end
    it do
      is_expected.to have_db_column(:city).of_type(:string)
        .with_options(null: false)
    end
  end

  describe 'indexes' do
    it { is_expected.to have_db_index(:socrata_provider_id).unique }
  end

  describe 'associations' do
    specify { is_expected.to belong_to :hospital_system }
    specify { is_expected.to have_many :accounts }
  end

  describe 'validations' do
    context 'no need to access the database' do
      subject { build_stubbed(described_class) }

      it { is_expected.to be_valid }

      it { is_expected.to validate_presence_of(:socrata_provider_id) }
      it { is_expected.to validate_presence_of(:name) }
      it { is_expected.to validate_presence_of(:city) }
      it { is_expected.to validate_presence_of(:state) }
    end

    context 'requires a record to be saved' do
      before { create(described_class) }
      it { is_expected.to validate_uniqueness_of(:socrata_provider_id) }
    end
  end

  describe '.create_or_update' do
    let(:new_attributes) do
      {
        'name' => 'Provider Name',
        'zip_code' => '36301',
        'hospital_type' => 'A really good one',
        'socrata_provider_id' => socrata_provider_id,
        'state' => 'AL',
        'city' => 'Dothan',
      }
    end
    let(:socrata_provider_id) { '123456' }

    def create_or_update!
      described_class.create_or_update!(new_attributes)
    end

    context 'no provider exists with this socrata_provider_id' do
      it 'creates the provider' do
        expect { create_or_update! }
          .to change(described_class, :count).by(1)
        expect(described_class.last.attributes)
          .to include new_attributes
      end
    end

    context 'a provider already exists with this socrata_provider_id' do
      let!(:existing_provider) do
        create(:provider, socrata_provider_id: socrata_provider_id)
      end

      it 'updates its attributes' do
        expect { create_or_update! }
          .to change { existing_provider.reload.attributes }
          .to hash_including(new_attributes)
      end
    end
  end

  describe '#hospital_system_name' do
    it do
      is_expected.to delegate_method(:hospital_system_name)
        .to(:hospital_system)
        .as(:name)
    end
  end

  describe '#city_and_state' do
    let(:provider) { create(described_class) }
    specify do
      expect(provider.city_and_state).to eq('SAN FRANCISCO, CA')
    end
  end

  describe 'context scopes' do
    let!(:system) { create(:hospital_system) }
    let!(:system1) { create(:hospital_system) }
    let!(:provider) do
      create(described_class, city: 'city1', state: 'state1',
                              hospital_system: system)
    end
    let!(:provider1) do
      create(described_class, city: 'city1', state: 'state1',
                              hospital_system: system1)
    end
    let!(:provider2) do
      create(described_class, city: 'city1', state: 'state2',
                              hospital_system: system1)
    end
    let!(:provider3) do
      create(described_class, city: 'city2', state: 'state1',
                              hospital_system: system1)
    end
    let!(:provider4) do
      create(described_class, city: 'city3', state: 'state3',
                              hospital_system: system)
    end
    let!(:provider_without_system) do
      create(described_class, city: 'city3', state: 'state3')
    end
    let!(:provider_without_system2) do
      create(described_class, city: 'city3', state: 'state3')
    end

    describe '.in_same_city' do
      it 'returns only providers in the same city and state' do
        expect(Provider.in_same_city(provider))
          .to match_array([provider, provider1])
      end
    end

    describe '.in_same_state' do
      it 'returns only providers in the same state' do
        expect(Provider.in_same_state(provider))
          .to match_array([provider, provider1, provider3])
      end
    end

    describe '.in_same_system' do
      context 'when hospital system is not nil' do
        it 'returns only providers in the same hospital system' do
          expect(Provider.in_same_system(provider))
            .to match_array([provider, provider4])
        end
      end

      context 'when hospital system is nil' do
        it 'returns only self' do
          expect(Provider.in_same_system(provider_without_system))
            .to match_array([provider_without_system])
        end
      end
    end
  end
end
