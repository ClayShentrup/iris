require 'socrata/result_iterator'

require 'pry'

RSpec.describe Socrata::ResultIterator, :vcr do
  use_vcr_cassette 'Socrata_ResultIterator/gets_some_results'

  subject do
    described_class.new(
      dataset_id: hospitals_dataset_id,
      required_fields: required_fields,
    )
  end
  let(:hospitals_dataset_id) { 'xubh-q36u' }
  let(:required_fields) do
    %w[
      provider_id
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
        'name' => 'SOUTHEAST ALABAMA MEDICAL CENTER',
        'provider_id' => '010001'
      },
      {
        'name' => 'MARSHALL MEDICAL CENTER SOUTH',
        'provider_id' => '010005'
      },
      {
        'name' => 'MIZELL MEMORIAL HOSPITAL',
        'provider_id' => '010007'
      }
    ]
  end

  it 'stores the length', vcr: { } do
    results
    expect(subject.length).to be 3
  end
end
