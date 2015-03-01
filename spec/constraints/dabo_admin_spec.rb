require './lib/constraints/dabo_admin'

RSpec.describe Constraints::DaboAdmin do
  subject(:constraint) { described_class.new }
  let(:request) { instance_double('Request', env: { 'warden' => warden }) }
  let(:warden) { double('Warden') }

  before do
    allow(warden).to receive(:authenticated?).and_return(false)
  end

  it 'denies an unauthenticated user' do
    expect(constraint.matches?(request)).to be_falsey
  end

  context 'when authenticated' do
    before do
      allow(warden).to receive(:authenticated?).and_return(true)
      allow(warden).to receive(:user).and_return(user)
    end

    context 'a normal user' do
      let(:user) { double('User', is_dabo_admin?: false) }

      it 'denies a non-admin user' do
        expect(constraint.matches?(request)).to be_falsey
      end
    end

    context 'an admin user' do
      let(:user) { double('User', is_dabo_admin?: true) }

      it 'allows access to an admin user' do
        expect(constraint.matches?(request)).to be_truthy
      end
    end
  end
end
