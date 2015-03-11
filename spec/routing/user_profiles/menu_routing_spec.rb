require 'rails_helper'

RSpec.describe UserProfiles::MenusController do
  describe 'routing' do
    include_context 'authenticated routing'
    include_context 'a singular resource'
    it_behaves_like 'a show route'
  end
end
