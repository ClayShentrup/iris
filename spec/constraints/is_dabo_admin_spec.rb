require './lib/constraints/is_dabo_admin'

RSpec.describe Constraints::IsDaboAdmin do
  context 'user is Dabo admin' do
    let(:user) { build_stubbed(:dabo_admin) }
    specify { expect(described_class.call(user)).to be true }
  end

  context 'user is not Dabo admin' do
    let(:user) { build_stubbed(User) }
    specify { expect(described_class.call(user)).to be false }
  end
end
