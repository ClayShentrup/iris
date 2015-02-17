require 'rails_helper'

RSpec.describe HospitalSearchResultsController do
  describe '#index' do
    login_user
    let(:ucsf) { 'UCSF' }
    let(:expected_search_results) do
      matching_hospitals.map do |hospital|
        hospital.attributes.slice('id', 'name', 'city', 'state')
      end
    end

    describe 'GET index' do
      let!(:matching_hospitals) do
        [
          create(:hospital, name: "#{ucsf} Mission Bay"),
          create(:hospital, name: "#{ucsf} Parnassus"),
        ]
      end
      let!(:non_matching_hospital) { create(:hospital, name: 'Other Hospital') }

      before do
        get 'index', term: ucsf
      end

      specify { expect(response).to be_successful }

      it 'calls Search::HospitalSearch and returns json' do
        expect(JSON.parse(response.body)).to eq expected_search_results
      end

      save_fixture 'default', type: :json
    end
  end
end
