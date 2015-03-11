require 'rails_helper'

RSpec.describe DataCategoriesController do
  describe 'routing' do
    include_context 'authenticated routing'

    context 'accessed via conventional route' do
      it_behaves_like 'an index route'
    end

    context 'accessed via product-friendly alias route' do
      let(:resource_name) { 'metrics' }
      it_behaves_like 'an index route'
    end
  end
end
