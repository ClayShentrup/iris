require 'rails_helper'

RSpec.describe StyleguidesController do
  before { get :show }

  specify { expect(response).to be_success }
  specify { expect(response).to render_template :show }
end
