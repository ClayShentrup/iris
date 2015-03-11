require 'accessible_bundle_ids'

RSpec.describe AccessibleBundleIds do
  let(:user) { double('User') }
  let(:account_bundles) do
    [double('a', bundle_id: 'a'), double('b', bundle_id: 'b')]
  end
  let(:expected_results) do
    [account_bundles[0].bundle_id, account_bundles[1].bundle_id]
  end

  before do
    allow(user).to receive(:account_bundles).and_return(account_bundles)
  end

  it 'returns bundle IDs' do
    expect(described_class.call(user)).to eq expected_results
  end
end
