require 'rails_helper'

RSpec.describe DaboAdmin::HospitalsController do
  let(:invalid_attributes) do
    attributes_for(Hospital, provider_id: '', name: '', city: '', state: '')
  end

  it_behaves_like 'an ApplicationController'
  it_behaves_like 'an ApplicationController index'
  it_behaves_like 'an ApplicationController new'
  it_behaves_like 'an ApplicationController create'
  it_behaves_like 'an ApplicationController show'
  it_behaves_like 'an ApplicationController delete'
end
