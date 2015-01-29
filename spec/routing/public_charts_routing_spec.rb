require 'rails_helper'

RSpec.describe PublicChartsController do
  describe 'routing' do
    let(:path) { "/metrics/#{public_chart_id}" }
    let(:public_chart_id) do
      %w[
        measures
        cms
        value-based-purchasing
        outcome-of-care
        mortality
        30-day-mortality-ami
      ].join('/')
    end

    specify do
      expect(get: path).to route_to(
          'public_charts#show',
          id: public_chart_id,
        )
    end
  end
end
