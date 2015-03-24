require 'active_record_no_rails_helper'
require 'socrata/dimension_sample_managers/graph_data_points/provider_aggregate'
require 'support/shared_contexts/socrata_value_dimension_sample_manager'

RSpec.describe Socrata::DimensionSampleManagers::GraphDataPoints::
               ProviderAggregate, :vcr do
  include_context 'socrata value dimension sample manager'

  context 'for provider aggregate dimension samples' do
    let(:dataset_id) { 'rrqw-56er' }
    let(:options) do
      {
        dataset_id: dataset_id,
        value_column_name: value_column_name,
      }
    end

    it_behaves_like 'a dimension sample manager'
  end
end
