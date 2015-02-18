require 'rails_helper'

RSpec.describe DaboAdmin::DaboAdminsController do
  login_admin

  it_behaves_like 'a Dabo Admin page'
end
