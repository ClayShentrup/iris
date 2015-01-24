require 'rails_helper'

RSpec.describe 'PublicCharts' do
  let(:user) { FactoryGirl.create(:user) }

  before do
    user.confirm!
    login_as(user)
  end

  describe 'GET inexistent public chart' do
    it 'returns a 404 status' do
      get '/measures/cms/some-non-existant-route'
      expect(response).to have_http_status(404)
    end
  end
end
