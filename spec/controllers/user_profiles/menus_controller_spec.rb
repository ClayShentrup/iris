require 'rails_helper'

RSpec.describe UserProfiles::MenusController do
  login_user

  it_behaves_like 'an ApplicationController show without a model'
end
