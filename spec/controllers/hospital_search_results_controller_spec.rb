require 'rails_helper'

RSpec.describe HospitalSearchResultsController do
  describe '#index' do
    login_user
    let(:ucsf) { 'UCSF' }
    let(:ucsf_mission_bay) { 'UCSF Mission Bay' }
    let(:ucsf_parnassus) { 'UCSF Parnassus' }

    let!(:matching_hospitals) do
      [
        create(:hospital, name: ucsf_mission_bay),
        create(:hospital, name: ucsf_parnassus),
      ]
    end
    let!(:non_matching_hospital) { create(:hospital, name: 'Other Hospital') }

    before do
      get 'index', term: search_term
    end

    describe 'return two hospitals' do
      let(:search_term) { ucsf }
      specify { expect(response).to be_successful }

      it 'calls index and returns search results' do
        expect(response.body).to have_content(ucsf_mission_bay)
        expect(response.body).to have_content(ucsf_parnassus)
      end

      save_fixture
    end

    describe 'return one hospital' do
      let(:search_term) { ucsf_mission_bay }
      save_fixture
    end
  end

  describe '#show' do
    login_user

    let(:hospital_system_name) { 'Test System' }
    let(:hospital_system) do
      create(:hospital_system, name: hospital_system_name)
    end
    let(:selected_hospital) do
      create(:hospital, hospital_system: hospital_system)
    end

    before do
      get 'show', id: selected_hospital.id
    end

    describe 'hospital to compare' do
      it 'returns hospital comparison options' do
        expect(response.body).to have_css('li', text: 'San Francisco, CA')
        expect(response.body).to have_css('li', text: 'CA')
        expect(response.body).to have_css('li', text: hospital_system_name)
      end

      save_fixture
    end
  end
end
