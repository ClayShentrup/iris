require 'rails_helper'

describe 'api/:hospitals' do
  it "routes to /api/:hospitals/" do
    expect(:get => "/api/hospitals/?q=xyz").
      to route_to('api/hospitals#index', :q => "xyz")
  end
end