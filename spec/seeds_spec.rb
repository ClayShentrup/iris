require 'rails_helper'

RSpec.describe 'rake db:seed' do
  it 'loads without error' do
    load Rails.root.join('db', 'seeds.rb')
  end
end
