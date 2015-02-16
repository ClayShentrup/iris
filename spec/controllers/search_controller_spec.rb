require 'rails_helper'

RSpec.describe SearchController do
  describe '#hospitals' do
    login_user
    let(:search_term) { 'blabla' }
    let(:search_results) { [{ abc: '123' }] }

    it 'calls Search::HospitalSearch and returns json' do
      expect(Search::HospitalSearch).to receive(:call).with(search_term)
        .and_return(search_results)
      get 'hospitals', term: search_term
      expect(response.body).to eq(search_results.to_json)
    end
  end
end
