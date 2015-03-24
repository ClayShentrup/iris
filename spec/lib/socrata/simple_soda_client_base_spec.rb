require 'socrata/simple_soda_client'

RSpec.describe Socrata::SimpleSodaClientBase, :vcr do
  def results
    described_class.call(
      dataset_id: hospitals_dataset_id,
      extra_query_options: {},
      required_columns: required_columns,
    )
  end
  let(:hospitals_dataset_id) { 'xubh-q36u' }
  let(:required_columns) do
    %w[
      provider_id
      hospital_name
    ]
  end

  before do
    stub_const('Socrata::SimpleSodaClientBase::PAGE_SIZE', 2)
  end

  it 'gets some results' do
    expect(results).to eq [
      {
        'hospital_name' => 'SOUTHEAST ALABAMA MEDICAL CENTER',
        'provider_id' => '010001',
      },
      {
        'hospital_name' => 'MARSHALL MEDICAL CENTER SOUTH',
        'provider_id' => '010005',
      },
      {
        'hospital_name' => 'MIZELL MEMORIAL HOSPITAL',
        'provider_id' => '010007',
      },
    ]
  end
end
