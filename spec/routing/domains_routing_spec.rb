require 'rails_helper'

RSpec.describe DomainsController do
  describe 'routing' do
    specify do
      expect(get: '/bundles/value-based-purchasing/domains')
        .to route_to(
          'domains#index',
          bundle_id: 'value-based-purchasing',
        )
    end
  end
end
