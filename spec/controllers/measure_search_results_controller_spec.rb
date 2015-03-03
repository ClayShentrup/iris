require 'rails_helper'

RSpec.describe MeasureSearchResultsController do
  login_user
  let(:hospitals) { create_list(Hospital, 1) }

  save_fixture do
    get :index, term: 'patient'
  end
end
