require 'rails_helper'

RSpec.describe NewsItemsController do
  describe 'routing' do
    include_context 'authenticated routing'

    context 'accessed via convential route' do
      it_behaves_like 'an index route'
    end

    context 'accessed as the root' do
      let(:resource_name) { '' }
      it_behaves_like 'an index route'
    end
  end
end
