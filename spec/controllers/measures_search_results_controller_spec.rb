require 'rails_helper'

RSpec.describe MeasuresSearchResultsController do
  login_user
  save_fixture do
    enable_feature :navbar_search
    get :index, term: 'test'
  end
end
