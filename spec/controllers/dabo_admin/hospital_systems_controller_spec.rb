require 'rails_helper'

RSpec.describe DaboAdmin::HospitalSystemsController do
  let(:invalid_attributes) { attributes_for(HospitalSystem, name: '') }
  login_admin

  include_context 'an ApplicationController'
  it_behaves_like 'an ApplicationController index'
  it_behaves_like 'an ApplicationController create'
  it_behaves_like 'an ApplicationController new'
  it_behaves_like 'an ApplicationController delete'
  it_behaves_like 'an ApplicationController show'
  it_behaves_like 'an ApplicationController edit'
  it_behaves_like 'an ApplicationController update'
end
