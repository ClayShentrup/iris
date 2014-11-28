require "rails_helper"

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
  end

  describe '.create_or_update' do
    let(:hospital_attributes) do
      {
        name: 'Hospital Name',
        zip_code: '36301',
        hospital_type: 'A really good one',
        provider_id: '123456',
        state: 'AL',
        city: 'Dothan',
      }.with_indifferent_access
    end

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
        create(:hospital, provider_id: hospital_attributes.fetch(:provider_id))
      end

      it 'updates its attributes' do
        expect { create_or_update }.not_to change(Hospital, :count)
        expect(existing_hospital.reload.attributes)
        .to include hospital_attributes
      end
    end
  end

  describe '.search' do
    let!(:east_side_hospital) do
      create(:hospital, name: 'East Side Hospital')
    end
    let!(:west_side_hospital) do
      create(:hospital, name: 'West Side Hospital')
    end
    let!(:north_side_hospital) do
      create(:hospital, name: 'North Side Hospital')
    end

    it 'finds only matching records, without case sensitivity' do
      expect(described_class.search('wEsT')).to eq [
        west_side_hospital
      ]
    end

    it 'finds all records if no query is specified' do
      expect(described_class.search(nil)).to match_array [
        east_side_hospital,
        west_side_hospital,
        north_side_hospital
      ]
    end
  end
end
