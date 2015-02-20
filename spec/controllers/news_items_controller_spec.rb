require 'rails_helper'

RSpec.describe NewsItemsController do
  login_user

  it_behaves_like 'an ApplicationController'

  save_fixture do
    enable_feature :navbar_search
    get :index
  end

  describe 'GET index' do
    before { get :index }

    specify { expect(response).to be_success }
    specify { expect(response).to render_template :index }
  end
end
