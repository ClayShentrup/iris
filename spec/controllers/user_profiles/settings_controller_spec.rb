require 'rails_helper'

RSpec.describe UserProfiles::SettingsController do
  login_user

  include_context 'an ApplicationController'
  it_behaves_like 'an ApplicationController index without a model'
end
