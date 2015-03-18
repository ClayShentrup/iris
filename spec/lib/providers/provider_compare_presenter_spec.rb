require 'spec_helper'
require 'active_record_no_rails_helper'
require 'providers/provider_compare_presenter'

RSpec.describe Providers::ProviderComparePresenter do
  let(:provider) { create(:provider) }

  subject { described_class.new(provider, 'city') }

  before do
    create(:provider, city: provider.city, state: provider.state)
    create(:provider, city: 'Los Angeles', state: provider.state)
  end

  it 'returns the city and state' do
    expect(subject.provider_city_and_state).to eq provider.city_and_state
  end

  it 'returns the state' do
    expect(subject.provider_state).to eq provider.state
  end

  it 'returns the system name' do
    expect(subject.hospital_system_name).to eq provider.hospital_system_name
  end

  it 'returns the number of providers in the city' do
    expect(subject.providers_in_city_count).to eq 2
  end

  it 'returns the number of providers in the state' do
    expect(subject.providers_in_state_count).to eq 3
  end

  context 'provider without hospital system' do
    it 'has a hospital system' do
      expect(subject.hospital_system?).to be false
    end

    it 'returns the total number of providers' do
      expect(subject.providers_count).to eq 3
    end
  end

  context 'provider with provider system' do
    let(:hospital_system) do
      create(:hospital_system, name: 'Test System')
    end
    let(:provider) do
      create(:provider, hospital_system: hospital_system)
    end

    before do
      create(:provider, hospital_system: hospital_system, state: 'NY')
    end

    it 'has a hospital system' do
      expect(subject.hospital_system?).to be true
    end

    it 'returns the number of providers in the system' do
      expect(subject.providers_in_system_count).to eq 2
    end

    it 'returns the total number of providers' do
      expect(subject.providers_count).to eq 4
    end
  end
end
