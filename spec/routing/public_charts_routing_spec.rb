require 'rails_helper'

RSpec.describe PublicChartsController do
  describe 'routing' do
    include_context 'authenticated routing'

    context 'accessed via product-friendly alias route' do
      let(:resource_name) { 'metrics' }
      it_behaves_like 'a show route'
    end
  end
end
