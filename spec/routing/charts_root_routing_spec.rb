require 'rails_helper'

RSpec.describe ChartsRootController do
  describe 'routing' do
    specify do
      expect(get: '/metrics').to route_to 'charts_root#show'
    end
  end
end
