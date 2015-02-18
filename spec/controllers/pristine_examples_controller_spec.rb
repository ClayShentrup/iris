require 'rails_helper'

RSpec.describe PristineExamplesController do
  login_user

  describe 'GET index' do
    save_fixture 'with feature enabled' do
      enable_feature(:pristine_example)
      get :index
    end
  end

  let(:invalid_attributes) { attributes_for(PristineExample, name: '') }
  it_behaves_like 'an ApplicationController'

  it_behaves_like 'an ApplicationController index'
  it_behaves_like 'an ApplicationController create'
  it_behaves_like 'an ApplicationController new'
  it_behaves_like 'an ApplicationController delete'
  it_behaves_like 'an ApplicationController show'
  it_behaves_like 'an ApplicationController edit'
  it_behaves_like 'an ApplicationController update'
end
