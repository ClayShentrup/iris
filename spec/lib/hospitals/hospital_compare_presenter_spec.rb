require 'spec_helper'
require 'active_record_no_rails_helper'
require 'hospitals/hospital_compare_presenter'

RSpec.describe Hospitals::HospitalComparePresenter do
  let(:hospital) { create(:hospital) }

  subject { described_class.new(hospital) }

  before do
    create(:hospital, city: hospital.city, state: hospital.state)
    create(:hospital, city: 'Los Angeles', state: hospital.state)
  end

  it 'returns the city and state' do
    expect(subject.hospital_city_and_state).to eq hospital.city_and_state
  end

  it 'returns the state' do
    expect(subject.hospital_state).to eq hospital.state
  end

  it 'returns the system name' do
    expect(subject.hospital_system_name).to eq hospital.hospital_system_name
  end

  it 'returns the number of hospitals in the city' do
    expect(subject.hospitals_in_city_count).to eq 2
  end

  it 'returns the number of hospitals in the state' do
    expect(subject.hospitals_in_state_count).to eq 3
  end

  context 'hospital without hospital system' do
    it 'has a hospital system' do
      expect(subject.hospital_system?).to be false
    end

    it 'returns the total number of hospitals' do
      expect(subject.hospitals_count).to eq 3
    end
  end

  context 'hospital with hospital system' do
    let(:hospital_system) do
      create(:hospital_system, name: 'Test System')
    end
    let(:hospital) do
      create(:hospital, hospital_system: hospital_system)
    end

    before do
      create(:hospital, hospital_system: hospital_system, state: 'NY')
    end

    it 'has a hospital system' do
      expect(subject.hospital_system?).to be true
    end

    it 'returns the number of hospitals in the system' do
      expect(subject.hospitals_in_system_count).to eq 2
    end

    it 'returns the total number of hospitals' do
      expect(subject.hospitals_count).to eq 4
    end
  end
end
