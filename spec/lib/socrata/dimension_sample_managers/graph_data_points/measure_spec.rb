require 'active_record_no_rails_helper'
require 'support/shared_contexts/socrata_value_dimension_sample_manager'
require 'socrata/dimension_sample_managers/graph_data_points/measure'

RSpec.describe Socrata::DimensionSampleManagers::GraphDataPoints::Measure do
  include_context 'socrata value dimension sample manager'

  context 'for measure dimension samples' do
    let(:vcr_directory) do
      'Socrata_DimensionSampleManagers_GraphDataPoints_Measure'
    end
    context 'lower is better' do
      let(:dataset_id) { '7xux-kdpw' }
      let(:options) { { measure_id: :PSI_90_SAFETY } }
      let(:cassette_name) { "#{vcr_directory}/lower_is_better" }
      it_behaves_like 'a dimension sample manager'
    end

    context 'higher is better' do
      let(:dataset_id) { 'dgck-syfz' }
      let(:options) { { measure_id: :H_COMP_1_A_P } }
      let(:cassette_name) { "#{vcr_directory}/higher_is_better" }
      it_behaves_like 'a DSM with national best performer value' do
        let(:national_best_performer_value) { '83' }
      end
    end
  end
end
