require 'rails_helper'

RSpec.describe SessionsController do
  context 'user already logged in' do
    login(:user)

    before { get :new }

    specify do
      expect(response).to redirect_to measures_url
    end
  end
end
