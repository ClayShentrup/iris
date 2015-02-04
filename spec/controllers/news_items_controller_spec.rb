require 'rails_helper'

RSpec.describe NewsItemsController do
  login(:user)

  it_behaves_like 'an ApplicationController'

  describe 'GET index' do
    save_fixture 'default' do
      enable_feature :navbar_search
      get :index
    end
  end

  describe 'GET index' do
    before { get :index }

    specify { expect(response).to be_success }
    specify { expect(response).to render_template :index }
  end
end
