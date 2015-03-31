require './app/models/provider'

RSpec.shared_context 'socrata value dimension sample manager' do
  subject { described_class.new(options) }

  let(:relevant_providers) { Provider.where(socrata_provider_id: provider_ids) }

  def create_relevant_providers
    provider_ids.each do |socrata_provider_id|
      create(
        Provider,
        name: "Hospital#{socrata_provider_id}",
        socrata_provider_id: socrata_provider_id,
      )
    end
  end

  def data
    subject.data(relevant_providers)
  end

  before { create_relevant_providers }

  let(:provider_ids) do
    %w[
      010087
      010103
      010317
      010415
      010418
    ]
  end
  let(:value_column_name) { :score }

  def import
    VCR.use_cassette(cassette_name) { subject.import }
  end

  shared_examples 'a DSM with national best performer value' do
    let(:national_best_performer_value) { '0.72' }

    it 'returns the lowest value' do
      import
      expect(subject.national_best_performer_value)
        .to eq national_best_performer_value
    end
  end

  shared_examples 'a dimension sample manager' do
    it 'pulls, persists, and returns data' do
      expect { import }.to change { data }
        .from([])
        .to [
          ['0.98', 'Hospital010087'],
          ['1.06', 'Hospital010103'],
        ]
    end

    it_behaves_like 'a DSM with national best performer value'
  end
end
