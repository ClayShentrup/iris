require 'socrata/rename_attributes'

RSpec.describe Socrata::RenameAttributes do
  let(:original_attributes) do
    {
      provider_id: '100010',
      hcahps_measure_id: 'PSI_90_SAFETY',
      score: '6.45',
    }
  end
  let(:rename_hash) do
    {
      hcahps_measure_id: :measure_id,
      score: :value,
    }
  end
  let(:expected_attributes) do
    {
      provider_id: '100010',
      measure_id: 'PSI_90_SAFETY',
      value: '6.45',
    }
  end

  def result
    described_class.call(
      attributes: original_attributes,
      rename_hash: rename_hash,
    )
  end

  it 'returns a new hash with the specified keys renamed' do
    expect(result).to eq expected_attributes
  end
end
