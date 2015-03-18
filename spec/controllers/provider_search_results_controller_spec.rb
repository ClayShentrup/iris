require 'rails_helper'

RSpec.describe ProviderSearchResultsController do
  describe '#index' do
    login_user
    let(:search_term) { 'UCSF' }
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

    it 'returns providers with matching names' do
      get 'index', term: search_term

      expect(response).to be_successful
      expect(response.body).to have_content(ucsf_mission_bay)
      expect(response.body).to have_content(ucsf_parnassus)
      expect(response.body).not_to have_content(non_matching_provider)
    end

    context 'generate fixtures' do
      before do
        expect(Provider).to receive(:search_results).and_return(providers)
        get 'index', term: 'foo'
      end
      describe 'two providers' do
        let(:providers) do
          [
            build_stubbed(:provider, id: 99),
            build_stubbed(:provider, id: 100),
          ]
        end
        save_fixture
      end
      describe 'one provider' do
        let(:providers) { [build_stubbed(:provider, id: 88)] }
        save_fixture
      end
    end
  end
end
