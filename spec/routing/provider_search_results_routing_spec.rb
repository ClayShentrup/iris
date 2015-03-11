require 'rails_helper'

RSpec.describe ProviderSearchResultsController do
  describe 'routing' do
    include_context 'authenticated routing'

    it_behaves_like 'an index route'
    it_behaves_like 'a show route'
  end
end
