require 'rails_helper'

RSpec.describe ConversationsController do
  describe 'routing' do
    include_context 'authenticated routing'

    it_behaves_like 'an index route'
    it_behaves_like 'a create route'
    it_behaves_like 'a show route'
  end
end
