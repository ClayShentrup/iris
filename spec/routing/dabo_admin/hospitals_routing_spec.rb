require 'rails_helper'

RSpec.describe DaboAdmin::HospitalsController do
  it_behaves_like('a DaboAdmin index route')
  it_behaves_like('a DaboAdmin new route')
  it_behaves_like('a DaboAdmin show route')
  it_behaves_like('a DaboAdmin edit route')
  it_behaves_like('a DaboAdmin create route')
  it_behaves_like('a DaboAdmin update route')
  it_behaves_like('a DaboAdmin destroy route')
end
