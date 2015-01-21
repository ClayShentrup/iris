require 'rails_helper'

RSpec.describe MeasuresRootController do
  describe 'routing' do
    specify do
      expect(get: '/measures').to route_to 'measures_root#show'
    end
  end
end
