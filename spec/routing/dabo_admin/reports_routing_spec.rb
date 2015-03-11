require 'rails_helper'

RSpec.describe DaboAdmin::ReportsController do
  describe 'routing' do
    include_context 'Dabo admin routing'

    it_behaves_like 'an index route'
  end
end
