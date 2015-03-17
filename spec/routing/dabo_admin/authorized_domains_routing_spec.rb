require 'rails_helper'

RSpec.describe DaboAdmin::AuthorizedDomainsController do
  describe 'routing' do
    include_context 'Dabo admin routing'

    it_behaves_like 'an index route' do
      let(:resource_name) { 'dabo_admin/accounts/1/authorized_domains' }
      let(:expected_route_options) { [expected_route, account_id: '1'] }
    end
    it_behaves_like 'a new route' do
      let(:resource_name) { 'dabo_admin/accounts/1/authorized_domains' }
      let(:expected_route_options) { [expected_route, account_id: '1'] }
    end
    it_behaves_like 'a show route'
    it_behaves_like 'an edit route'
    it_behaves_like 'a create route' do
      let(:resource_name) { 'dabo_admin/accounts/1/authorized_domains' }
      let(:expected_route_options) { [expected_route, account_id: '1'] }
    end
    it_behaves_like 'an update route'
    it_behaves_like 'a destroy route'
  end
end
