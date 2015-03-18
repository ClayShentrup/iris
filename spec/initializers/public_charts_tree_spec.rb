require 'rails_helper'

RSpec.describe 'PUBLIC_CHARTS_TREE', :vcr do
  it 'refreshes dimension samples successfully' do
    PUBLIC_CHARTS_TREE.refresh
  end
end
