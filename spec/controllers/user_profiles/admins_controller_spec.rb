require 'rails_helper'

RSpec.describe UserProfiles::AdminsController do
  login_admin

  it_behaves_like 'an ApplicationController show without a model'
end
