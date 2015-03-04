require 'rails_helper'

RSpec.describe StyleguidesController do
  it_behaves_like 'an ApplicationController without authentication'

  before { get :show }

  specify { expect(response).to be_success }

  it 'renders style guide' do
    expect(response.body).to include 'Dabo Health Styleguide'
  end
end
