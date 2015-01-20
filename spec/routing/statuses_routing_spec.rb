require 'rails_helper'

RSpec.describe StatusesController do
  describe 'routing' do
    specify do
      expect(get: '/status').to route_to('statuses#show')
    end
  end
end
