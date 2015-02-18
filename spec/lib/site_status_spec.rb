require 'active_record_no_rails_helper'
require 'site_status'

RSpec.describe SiteStatus do
  context 'when all checks return a successful response' do
    let(:result_hash) { described_class.call }

    specify do
      expect(result_hash).to eq(
        overall_status: 'All is well',
        checks: {
          database_status: 'OK',
        },
      )
    end

    context 'with an unsucessful database connection' do
      before do
        allow(ActiveRecord::Base.connection).to receive(:execute).and_raise(
          ActiveRecord::ConnectionTimeoutError,
        )
      end

      it 'returns an error message' do
        expect(result_hash[:overall_status]).to eq 'Something went wrong'
        expect(result_hash[:checks][:database_status])
          .to eq('ActiveRecord::ConnectionTimeoutError')
      end

      after do
        allow(ActiveRecord::Base.connection)
          .to receive(:execute).and_call_original
      end
    end
  end
end
