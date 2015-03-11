require 'rails_helper'

RSpec.describe ChartsRootController do
  login_user

  it_behaves_like 'an ApplicationController'

  describe 'GET show' do
    before do
      get :show
    end

    it 'renders the index template' do
      expect(response).to render_template :show
    end

    it 'renders public data button' do
      expect(response.body).to include 'Public Data'
    end
  end
end
