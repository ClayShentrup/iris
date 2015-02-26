require 'rails_helper'

RSpec.describe UserProfilesController do
  describe 'user profiles routing' do
    let(:path) { "/user_profiles/#{page_id}" }

    %w[menu info settings].each do |page_id|
      context page_id do
        let(:page_id) { page_id }
        it 'routes to the correct page' do
          expect(get: path).to route_to(
            'user_profiles#show',
            id: page_id,
            )
        end
      end
    end
  end
end
