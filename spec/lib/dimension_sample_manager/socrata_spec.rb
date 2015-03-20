require 'active_record_no_rails_helper'
require 'dimension_sample_managers/socrata'

RSpec.describe DimensionSampleManagers::Socrata, :vcr do
  subject do
    DimensionSampleManagers::Socrata.new(
      options.merge(dataset_id: dataset_id),
    )
  end

  let(:relevant_providers) { Provider.where(socrata_provider_id: provider_ids) }

  def create_relevant_providers
    provider_ids.each do |socrata_provider_id|
      create(Provider, socrata_provider_id: socrata_provider_id)
    end
  end

  def data
    subject.data(relevant_providers)
  end

  before do
    stub_const(
      'DATASETS',
      'rrqw-56er' => { dataset_type: :single_measure },
      '7xux-kdpw' => { dataset_type: :measure },
    )
    create_relevant_providers
  end

  context 'data rows have provider_id' do
    let(:provider_ids) do
      %w[
        010087
        010103
        010317
        010415
        010418
      ]
    end
    let(:column_name) { :score }

    shared_examples 'a dimension sample manager' do
      it 'pulls, persists, and returns data' do
        expect { subject.refresh }.to change { data }
          .from([])
          .to %w[
            0.98
            1.06
          ]
      end
    end

    context 'for single-measure dimension samples' do
      let(:dataset_id) { 'rrqw-56er' }
      let(:options) { { column_name: column_name } }

      it_behaves_like 'a dimension sample manager'
    end

    context 'for measure dimension samples', :vcr do
      let(:dataset_id) { '7xux-kdpw' }
      let(:options) do
        {
          column_name: column_name,
          measure_id: :PSI_90_SAFETY,
        }
      end

      it_behaves_like 'a dimension sample manager'
    end
  end
end
