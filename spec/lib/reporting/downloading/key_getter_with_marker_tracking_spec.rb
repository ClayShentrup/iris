require 'reporting/downloading/key_getter_with_marker_tracking'

RSpec.describe Reporting::Downloading::KeyGetterWithMarkerTracking do
  subject do
    described_class.new(
      s3_keys_enumerator: enumerator,
      initial_marker: initial_marker,
    )
  end
  let(:enumerator) { [1, 2, 3] }
  let(:initial_marker) { nil }

  it 'passes through the behavior of the passed enumerator' do
    expect(subject.to_a).to eq enumerator
  end

  context 'with a lazy enumerator' do
    let(:enumerator) { (0..2).lazy }

    it 'does not break laziness' do
      enumerator_2 = subject.map { fail }
      expect { enumerator_2.force }.to raise_error(RuntimeError)
    end
  end

  describe '#marker' do
    it 'returns the last item returned' do
      expect(subject.marker).to eq enumerator.last
    end

    context 'with an empty list' do
      let(:enumerator) { [] }

      it 'returns the initial marker' do
        expect(subject.marker).to eq initial_marker
      end
    end
  end
end
