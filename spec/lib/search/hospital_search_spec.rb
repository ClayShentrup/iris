require 'active_record_no_rails_helper'
require 'search/hospital_search'

RSpec.describe Search::HospitalSearch do
  let!(:matching_hospital_1) { create :hospital, name: 'My Hospital 1' }
  let!(:matching_hospital_2) { create :hospital, name: 'My Hospital 2' }
  let!(:non_matching_hospital) { create :hospital, name: 'Other Hospital' }
  let(:matching_hospital_1_result) do
    {
      id: matching_hospital_1.id,
      name: matching_hospital_1.name,
      city: matching_hospital_1.city.titleize,
      state: matching_hospital_1.state,
    }
  end
  let(:result) { described_class.call('My Hospital') }

  describe '#call' do
    it 'returns matching hospitals for a search term' do
      expect(result.first.fetch(:name)).to eq 'My Hospital 1'
      expect(result.second.fetch(:name)).to eq 'My Hospital 2'
    end

    it 'does not include non matching hospitals' do
      expect(result.any? { |h| h.fetch(:name) == 'Other Hospital' }).to eq false
    end

    it 'returns the expected hash' do
      expect(result.first).to eq matching_hospital_1_result
    end
  end
end
