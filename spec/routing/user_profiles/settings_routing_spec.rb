require 'rails_helper'

RSpec.describe UserProfiles::SettingsController do
  describe 'routing' do
    include_context 'authenticated routing'
    it_behaves_like 'an index route'
  end
end
