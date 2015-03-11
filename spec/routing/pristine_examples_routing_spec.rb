require 'rails_helper'

RSpec.describe PristineExamplesController do
  describe 'routing' do
    include_context 'authenticated routing'

    it_behaves_like 'an index route'
    it_behaves_like 'a new route'
    it_behaves_like 'a show route'
    it_behaves_like 'an edit route'
    it_behaves_like 'a create route'
    it_behaves_like 'an update route'
    it_behaves_like 'a destroy route'
  end
end
