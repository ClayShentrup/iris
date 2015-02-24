require 'spec_helper'
require 'active_record_no_rails_helper'
require 'hospitals/hospital_comparison'

RSpec.describe Hospitals::HospitalComparison do
  let(:hospital_system) do
    create(:hospital_system, name: 'Test System')
  end
  let(:hospital) do
    create(:hospital, hospital_system: hospital_system)
  end

  subject { described_class.new(hospital) }

  before do
    create(:hospital, city: hospital.city, state: hospital.state)
    create(:hospital, city: 'Los Angeles', state: hospital.state)
    create(:hospital, hospital_system: hospital_system, state: 'NY')
  end

  it 'returns the city and state' do
    expect(subject.city_and_state).to eq hospital.city_and_state
  end

  it 'returns the state' do
    expect(subject.state).to eq hospital.state
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

  it 'returns the number of hospitals in the system' do
    expect(subject.hospitals_in_system_count).to eq 2
  end

  it 'returns the total number of hospitals' do
    expect(subject.hospitals_count).to eq 4
  end
end
