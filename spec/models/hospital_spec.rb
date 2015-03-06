# == Schema Information
#
# Table name: hospitals
#
#  id                 :integer          not null, primary key
#  name               :string           not null
#  zip_code           :string           not null
#  hospital_type      :string           not null
#  provider_id        :string           not null
#  state              :string           not null
#  city               :string           not null
#  hospital_system_id :integer
#

require 'active_record_no_rails_helper'
require './app/models/hospital'
require './app/models/hospital_system'

RSpec.describe Hospital do
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
      is_expected.to have_db_column(:provider_id).of_type(:string)
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

  describe 'validations' do
    context 'no need to access the database' do
      subject { build_stubbed(described_class) }

      it { is_expected.to be_valid }

      it { is_expected.to validate_presence_of(:provider_id) }
      it { is_expected.to validate_presence_of(:name) }
      it { is_expected.to validate_presence_of(:city) }
      it { is_expected.to validate_presence_of(:state) }
    end

    context 'requires a record to be saved' do
      before { create(described_class) }
      it { is_expected.to validate_uniqueness_of(:provider_id) }
    end
  end

  describe '.create_or_update' do
    let(:new_attributes) do
      {
        'name' => 'Hospital Name',
        'zip_code' => '36301',
        'hospital_type' => 'A really good one',
        'provider_id' => provider_id,
        'state' => 'AL',
        'city' => 'Dothan',
      }
    end
    let(:provider_id) { '123456' }

    def create_or_update!
      described_class.create_or_update!(new_attributes)
    end

    context 'no hospital exists with this provider_id' do
      it 'creates the hospital' do
        expect { create_or_update! }
          .to change(described_class, :count).by(1)
        expect(described_class.last.attributes)
          .to include new_attributes
      end
    end

    context 'a hospital already exists with this provider_id' do
      let!(:existing_hospital) do
        create(:hospital, provider_id: provider_id)
      end

      it 'updates its attributes' do
        expect { create_or_update! }
          .to change { existing_hospital.reload.attributes }
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
    let(:hospital) { create(described_class) }
    specify do
      expect(hospital.city_and_state).to eq('SAN FRANCISCO, CA')
    end
  end
end
