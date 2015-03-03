require 'rails_helper'

RSpec.describe MeasureSearchResultsController do
  login_user
  let(:hospitals) { create_list(Hospital, 1) }

  save_fixture do
    enable_feature :navbar_search
    get :index, term: 'patient'
  end
end
