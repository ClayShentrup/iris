require 'socrata/simple_soda_client'

RSpec.describe Socrata::SimpleSodaClient, :vcr do
  subject do
    described_class.new(
      dataset_id: hospitals_dataset_id,
      required_columns: required_columns,
    )
  end
  let(:hospitals_dataset_id) { 'xubh-q36u' }
  let(:required_columns) do
    %w[
      socrata_provider_id
      hospital_name
    ]
  end

  let(:results) { subject.to_a }

  before do
    stub_const('Socrata::SimpleSodaClient::PAGE_SIZE', 2)
  end

  it 'gets some results' do
    expect(results).to eq [
      {
        'hospital_name' => 'SOUTHEAST ALABAMA MEDICAL CENTER',
        'socrata_provider_id' => '010001',
      },
      {
        'hospital_name' => 'MARSHALL MEDICAL CENTER SOUTH',
        'socrata_provider_id' => '010005',
      },
      {
        'hospital_name' => 'MIZELL MEMORIAL HOSPITAL',
        'socrata_provider_id' => '010007',
      },
    ]
  end

  it 'stores the length' do
    expect(results.size).to be 3
  end
end
