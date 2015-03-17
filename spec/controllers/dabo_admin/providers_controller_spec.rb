require 'rails_helper'

RSpec.describe DaboAdmin::ProvidersController do
  login_admin

  let(:invalid_attributes) do
    attributes_for(
      Provider,
      socrata_provider_id: '',
      name: '',
      city: '',
      state: '',
    )
  end

  include_context 'an ApplicationController'
  it_behaves_like 'an ApplicationController index'
  it_behaves_like 'an ApplicationController new'
  it_behaves_like 'an ApplicationController create'
  it_behaves_like 'an ApplicationController show'
  it_behaves_like 'an ApplicationController delete'
end
