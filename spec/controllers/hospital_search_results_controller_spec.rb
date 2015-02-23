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

    let(:hospital_system) do
      create(:hospital_system, name: 'Test System')
    end
    let(:selected_hospital) do
      create(:hospital, hospital_system: hospital_system)
    end

    before do
      get 'show', id: selected_hospital.id
    end

    describe 'hospital to compare' do
      it 'returns hospital comparison options' do
        expect(response.body).to have_css(
          'li:nth-child(1)',
          text: selected_hospital.city_and_state,
        )
        expect(response.body).to have_css(
          'li:nth-child(2)',
          text: selected_hospital.state,
        )
        expect(response.body).to have_css(
          'li:nth-child(3)',
          text: selected_hospital.hospital_system_name,
        )
      end

      save_fixture
    end
  end
end
