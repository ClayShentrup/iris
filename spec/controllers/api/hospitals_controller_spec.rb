require 'rails_helper'
require 'support/shared_examples/json_controller'

RSpec.describe Api::HospitalsController do
  it_behaves_like 'a controller which ensures a JSON request'

  describe 'index' do
    let(:query) { 'Foo' }
    let(:hospitals) { build_stubbed_pair(:hospital) }

    before do
      allow(Hospital).to receive(:search).with(query).and_return(hospitals)
      get :index, format: :json, q: query
    end

    it 'sets the hospitals' do
      expect(assigns(:hospitals)).to be hospitals
    end

    it 'is successful' do
      expect(response).to be_successful
    end
  end
end
