require 'active_record_no_rails_helper'
require 'dimension_sample_managers/socrata'
require 'socrata/datasets/hospital_value_based_purchasing'
require './app/models/hospital'
require './app/models/dimension_sample/single_measure'

RSpec.describe DimensionSampleManagers::Socrata, :vcr do
  subject do
    DimensionSampleManagers::Socrata.new(
      dataset: dataset,
      options: options,
    )
  end

  let(:data) { subject.data(relevant_providers) }
  let(:relevant_providers) { Hospital.where(provider_id: provider_ids) }

  def create_relevant_providers
    provider_ids.each do |provider_id|
      create(Hospital, provider_id: provider_id)
    end
  end

  before do
    create_relevant_providers
  end

  context 'for single-measure dimension samples' do
    let(:dataset) { :HospitalValueBasedPurchasing }
    let(:options) { { column_name: :weighted_outcome_domain_score } }
    let(:provider_ids) do
      %w[
        010087
        010103
        010317
        010415
        010418
      ]
    end

    it 'pulls, persists, and returns data' do
      subject.refresh
      expect(data).to eq %w[
        0.000000000000
        7.200000000000
      ]
    end
  end
end
