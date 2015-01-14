require 'rails_helper'

RSpec.describe BundleMeasuresController do
  describe 'GET show' do
    before do
      get :show, id: '1'
    end

    it 'renders the show template' do
      expect(response).to render_template('show')
    end
  end
end
