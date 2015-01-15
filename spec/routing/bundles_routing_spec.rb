require 'rails_helper'

RSpec.describe BundlesController do
  describe 'routing' do
    specify do
      expect(get: '/measure_sources/cms/bundles')
        .to route_to('bundles#index', measure_source_id: 'cms')
    end
  end
end
