require 'rails_helper'

RSpec.describe MeasureSearchResultsController do
  login_user

  let(:bundle_ids) do
    %w[
      value-based-purchasing
      hospital-acquired-conditions
      readmissions-reduction-program
      hospital-consumer-assessment-of-healthcare-providers-and-systems
      surgical-care-improvement-project
    ]
  end

  before do
    allow(AccessibleBundleIds).to receive(:call).and_return(bundle_ids)
  end

  it_behaves_like 'an ApplicationController'

  save_fixture do
    get :index, term: 'patient'
  end
end
