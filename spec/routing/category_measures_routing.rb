require 'rails_helper'

RSpec.describe CategoryMeasuresController do
  describe 'routing' do
    specify do
      expect(get: '/categories/mortality/category_measures')
        .to route_to(
          'category_measures#index',
          category_id: 'mortality',
        )
    end

    specify do
      expect(
        get: '/category_measures/30-day-mortality-ami',
      ).to route_to(
        'category_measures#show',
        id: '30-day-mortality-ami',
      )
    end
  end
end
