require 'rails_helper'

RSpec.describe StatusesController do
  it_behaves_like 'an ApplicationController without authentication'

  before { get :show }

  specify do
    expect(response).to be_success
  end

  it 'renders public data button' do
    expect(response.body).to include 'All is well'
  end
end
