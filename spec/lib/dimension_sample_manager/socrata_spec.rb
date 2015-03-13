require 'active_record_no_rails_helper'
require 'dimension_sample_managers/socrata'
require './app/models/provider'
require './app/models/dimension_sample/single_measure'

RSpec.describe DimensionSampleManagers::Socrata, :vcr do
  subject do
    DimensionSampleManagers::Socrata.new(
      dataset_id: dataset_id,
      options: options,
    )
  end

  let(:data) { subject.data(relevant_providers) }
  let(:relevant_providers) { Provider.where(socrata_provider_id: provider_ids) }

  def create_relevant_providers
    provider_ids.each do |socrata_provider_id|
      create(Provider, socrata_provider_id: socrata_provider_id)
    end
  end

  before do
    stub_const(
      'DATASETS',
      'rrqw-56er' => { dataset_type: :single_measure },
    )
    create_relevant_providers
  end

  context 'for single-measure dimension samples' do
    let(:dataset_id) { 'rrqw-56er' }
    let(:column_name) { :score }
    let(:options) { { column_name: column_name } }
    let(:provider_ids) do
      %w[
        010087
        010103
        010317
        010415
        010418
      ]
    end
    let(:cassette) do
      %w[
        DimensionSampleManagers_Socrata
        for_single-measure_dimension_samples
        pulls_persists_and_returns_data
      ].join('/')
    end

    shared_examples 'a socrata data sample manager' do
      before do
        VCR.use_cassette(cassette) { subject.refresh }
      end

      it 'pulls, persists, and returns data' do
        expect(data).to eq %w[
          0.98
          1.06
        ]
      end
    end

    context 'for a dataset with PROVIDER_ID_COLUMN_NAME specified' do
      it_behaves_like 'a socrata data sample manager'
    end

    context 'for a dataset without PROVIDER_ID_COLUMN_NAME specified' do
      it_behaves_like 'a socrata data sample manager'
    end
  end
end
