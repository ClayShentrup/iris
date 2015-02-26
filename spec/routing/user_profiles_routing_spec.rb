require 'rails_helper'

RSpec.describe UserProfilesController do
  describe 'user profiles routing' do
    let(:path) { "/user_profiles/#{page_id}" }

    context 'menu' do
      let(:page_id) { 'menu' }
      it 'routes to the correct page' do
        expect(get: path).to route_to(
          'user_profiles#show',
          id: page_id,
          )
      end
    end
  end
end
