require 'rails_helper'

RSpec.describe CategoriesController do
  describe 'GET show' do
    before do
      get :show
    end

    it 'renders the show template' do
      expect(response).to render_template('show')
    end
  end
end
