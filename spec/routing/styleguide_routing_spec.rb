require 'rails_helper'

RSpec.describe StyleguidesController do
  describe 'routing' do
    include_context 'routing'
    include_context 'a singular resource'
    it_behaves_like 'a show route'
  end
end
