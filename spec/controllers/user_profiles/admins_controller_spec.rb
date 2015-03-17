require 'rails_helper'

RSpec.describe UserProfiles::AdminsController do
  login_admin

  include_context 'an ApplicationController'
  it_behaves_like 'an ApplicationController show without a model'
end
