require 'rails_helper'

RSpec.describe 'PUBLIC_CHARTS_TREE', :vcr do
  it 'imports dimension samples successfully' do
    PUBLIC_CHARTS_TREE.import_all
  end
end
