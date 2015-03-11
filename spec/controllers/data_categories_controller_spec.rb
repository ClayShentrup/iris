require 'rails_helper'

RSpec.describe DataCategoriesController do
  describe 'GET index' do
    login_user

    before do
      get :index
    end

    specify { expect(response).to be_success }
    specify { expect(response).to render_template :index }
  end
end
