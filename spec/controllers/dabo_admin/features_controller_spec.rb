require 'rails_helper'

RSpec.describe DaboAdmin::FeaturesController do
  login(:dabo_admin)

  it_behaves_like 'a Dabo Admin page'
end
