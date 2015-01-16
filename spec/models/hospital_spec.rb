# == Schema Information
#
# Table name: hospitals
#
#  id                 :integer          not null, primary key
#  name               :string
#  zip_code           :string
#  hospital_type      :string
#  provider_id        :string
#  state              :string
#  city               :string
#  hospital_system_id :integer
#

require 'active_record_spec_helper'
require './app/models/hospital'

RSpec.describe Hospital do
  describe 'attributes' do
    it { should have_db_column(:name).of_type(:string) }
    it { should have_db_column(:zip_code).of_type(:string) }
    it { should have_db_column(:hospital_type).of_type(:string) }
    it { should have_db_column(:provider_id).of_type(:string) }
    it { should have_db_column(:state).of_type(:string) }
    it { should have_db_column(:city).of_type(:string) }
  end

  describe 'validations' do
    context 'no need to access the database' do
      subject { build_stubbed(described_class) }

      it { should be_valid }
    end

    it { should validate_uniqueness_of(:provider_id) }
    it { should validate_presence_of(:provider_id) }
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:city) }
    it { should validate_presence_of(:state) }
  end

  describe '.create_or_update' do
    let(:hospital_attributes) do
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

    def create_or_update
      described_class.create_or_update(hospital_attributes)
    end

    context 'no hospital exists with this provider_id' do
      it 'creates the hospital' do
        expect { create_or_update }.to change(Hospital, :count).by(1)
        expect(Hospital.last.attributes).to include hospital_attributes
      end
    end

    context 'a hospital already exists with this provider_id' do
      let!(:existing_hospital) do
        create(:hospital, provider_id: provider_id)
      end

      it 'updates its attributes' do
        expect { create_or_update }.not_to change(Hospital, :count)
        expect(existing_hospital.reload.attributes)
          .to include hospital_attributes
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
end
