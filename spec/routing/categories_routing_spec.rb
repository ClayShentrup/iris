require 'rails_helper'

RSpec.describe CategoriesController do
  describe 'routing' do
    specify do
      expect(get: '/domains/outcome-of-care/categories')
        .to route_to(
          'categories#index',
          domain_id: 'outcome-of-care',
        )
    end
  end
end
