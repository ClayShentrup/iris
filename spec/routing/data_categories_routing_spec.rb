require 'rails_helper'

RSpec.describe DataCategoriesController do
  describe 'routing' do
    include_context 'authenticated routing'
    let(:resource_name) { 'metrics' }

    it_behaves_like 'an index route'
  end
end
