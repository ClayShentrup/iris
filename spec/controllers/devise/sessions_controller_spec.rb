require 'rails_helper'

RSpec.describe Devise::SessionsController do
  simulate_routed_request
  save_fixture do
    get :new
  end
end
