require 'rails_helper'

RSpec.describe CommentsController do
  describe 'routing' do
    include_context 'authenticated routing'

    it_behaves_like 'a create route'
  end
end
