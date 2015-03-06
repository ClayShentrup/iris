require 'rails_helper'

RSpec.describe ProviderSearchResultsController do
  describe '#index' do
    login_user
    let(:ucsf) { 'UCSF' }
    let(:ucsf_mission_bay) { 'UCSF Mission Bay' }
    let(:ucsf_parnassus) { 'UCSF Parnassus' }

    let!(:matching_providers) do
      [
        create(:provider, name: ucsf_mission_bay),
        create(:provider, name: ucsf_parnassus),
      ]
    end
    let!(:non_matching_provider) do
      create(:provider, name: 'Other Provider')
    end

    before do
      get 'index', term: search_term
    end

    describe 'return two providers' do
      let(:search_term) { ucsf }
      specify { expect(response).to be_successful }

      it 'calls index and returns search results' do
        expect(response.body).to have_content(ucsf_mission_bay)
        expect(response.body).to have_content(ucsf_parnassus)
        expect(response.body).not_to have_content(non_matching_provider)
      end

      save_fixture
    end

    describe 'return one provider' do
      let(:search_term) { ucsf_mission_bay }
      save_fixture
    end
  end

  describe '#show' do
    login_user

    let!(:provider_in_same_city) do
      create(
        :provider,
        city: selected_provider.city,
        state: selected_provider.state,
      )
    end
    let!(:provider_in_same_state) do
      create(:provider, city: 'Los Angeles', state: selected_provider.state)
    end

    context 'provider to compare has hospital system' do
      let(:hospital_system) do
        create(:hospital_system, name: 'Test System')
      end
      let(:selected_provider) do
        create(:provider, hospital_system: hospital_system)
      end
      let!(:provider_in_same_system) do
        create(:provider, hospital_system: hospital_system, state: 'NY')
      end

      before do
        get 'show', id: selected_provider.id
      end

      it 'returns provider comparison options' do
        expect(response.body).to have_content(
          "#{selected_provider.city_and_state} 2 Providers",
        )
        expect(response.body).to have_content(
          "#{selected_provider.state} 3 Providers",
        )
        expect(response.body).to have_content(
          "#{selected_provider.hospital_system_name} 2 Providers",
        )
        expect(response.body).to have_content(
          'Nation-wide 4 Providers',
        )
        expect(response.body).to have_css('li', count: 4)
      end

      save_fixture
    end

    context 'provider to compare does not have hospital system' do
      let(:selected_provider) { create(:provider) }

      before do
        get 'show', id: selected_provider.id
      end

      it 'returns provider comparison options' do
        expect(response.body).to have_content(
          "#{selected_provider.city_and_state} 2 Providers",
        )
        expect(response.body).to have_content(
          "#{selected_provider.state} 3 Providers",
        )
        expect(response.body).to have_content(
          'Nation-wide 3 Providers',
        )
        expect(response.body).to have_css('li', count: 3)
      end
    end
  end
end
