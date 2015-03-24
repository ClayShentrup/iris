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

  before do
    stub_const(
      'DATASETS',
      'rrqw-56er' => { dataset_type: :provider_aggregate },
      '7xux-kdpw' => { dataset_type: :measure },
    )
    create_relevant_providers
  end

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

  shared_examples 'a dimension sample manager' do
    it 'pulls, persists, and returns data' do
      expect { subject.import }.to change { data }
        .from([])
        .to [
          ['0.98', 'Hospital010087'],
          ['1.06', 'Hospital010103'],
        ]
    end
  end
end
