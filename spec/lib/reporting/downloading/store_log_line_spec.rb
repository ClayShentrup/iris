require 'active_record_no_rails_helper'
require 'reporting/downloading/store_log_line'

RSpec.describe Reporting::Downloading::StoreLogLine do
  let(:log_line_attributes) do
    {
      heroku_request_id: heroku_request_id,
      logged_at: logged_at,
      data: data,
    }
  end
  let(:heroku_request_id) { '0f1e5956-de1b-41bf-b080-baec304fc04b' }
  let(:logged_at) { '2014-09-08T23:11:14.780027+00:00' }
  let(:data) { { 'foo' => 'SOME ARBITRARY JSON' } }

  def store_log_line
    described_class.call(log_line_attributes)
  end

  it 'saves a new log line' do
    expect { store_log_line }.to change(LogLine, :count).by(1)
    expect(
      LogLine.last.attributes.with_indifferent_access,
    ).to include log_line_attributes
  end

  context 'when the log line has already been saved' do
    before do
      LogLine.create!(log_line_attributes)
    end

    it 'does not save a new record' do
      expect { store_log_line }.not_to change(LogLine, :count)
    end
  end

  context 'when the record is invalid' do
    let(:heroku_request_id) { invalid_request_id }
    let(:invalid_request_id) { '' }

    it 'raises an exception' do
      expect { store_log_line }.to raise_error ActiveRecord::RecordInvalid
    end
  end
end
