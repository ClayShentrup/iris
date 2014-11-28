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

  describe ".from_hashie_mash" do
    let(:row) do
      OpenStruct.new(
        :hospital_name => 'xyz',
        :zip_code => '94114',
        :hospital_type => 'some type',
        :provider_id => 'some provider id',
        :state => 'CA',
        :city => 'SOME CITY'
      )
    end

    it "should create a new record if not found by provider_id" do
      described_class.from_hashie_mash(row)
      expect(Hospital.count).to eq(1)
      expect(Hospital.first.name).to eq('xyz')
    end

    it "should update the info if the hospital is found" do
      FactoryGirl.create(:hospital,
        :name => 'old name',
        :zip_code => '94114',
        :hospital_type => 'some type',
        :provider_id => 'some provider id',
        :state => 'CA',
        :city => 'SOME CITY'
      )

      expect(Hospital.first.name).to eq('old name')

      described_class.from_hashie_mash(row)
      expect(Hospital.count).to eq(1)
      expect(Hospital.first.name).to eq('xyz')
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
