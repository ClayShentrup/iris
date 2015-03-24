require 'active_record_no_rails_helper'
require 'support/shared_contexts/socrata_value_dimension_sample_manager'
require 'socrata/dimension_sample_managers/graph_data_points/measure'

RSpec.describe Socrata::DimensionSampleManagers::GraphDataPoints::Measure,
               :vcr do
  include_context 'socrata value dimension sample manager'

  context 'for measure dimension samples', :vcr do
    let(:dataset_id) { '7xux-kdpw' }
    let(:options) { { measure_id: :PSI_90_SAFETY } }

    it_behaves_like 'a dimension sample manager'
  end
end
