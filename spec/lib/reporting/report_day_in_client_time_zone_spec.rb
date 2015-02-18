require 'active_support/core_ext/time/zones'
require 'reporting/report_day_in_client_time_zone'

RSpec.describe Reporting::ReportDayInClientTimeZone, :time do
  let(:now) { beginning_of_yesterday + 1.day + 23.hours }
  let(:beginning_of_yesterday) { client_time_zone.parse('2014-08-04') }
  let(:client_time_zone) { Time.find_zone!('Melbourne') }

  def stub_client_time_zone
    stub_const('APP_CONFIG', double(client_time_zone: client_time_zone))
  end

  def report_day_in_client_time_zone
    Timecop.freeze(now) do
      described_class.call(report_date_string)
    end
  end

  before do
    stub_client_time_zone
  end

  context 'when a report date is provided' do
    let(:report_date_string) { '2013-09-30' }

    it "returns the datetime for the start of client time zone's report date" do
      expect(report_day_in_client_time_zone.to_s)
        .to eq '2013-09-30 00:00:00 +1000...2013-10-01 00:00:00 +1000'
    end
  end

  context 'when no report date is provided' do
    let(:report_date_string) { nil }

    it "returns a datetime for the start of yesterday in client's time zone" do
      expect(report_day_in_client_time_zone.to_s)
        .to eq '2014-08-04 00:00:00 +1000...2014-08-05 00:00:00 +1000'
    end
  end
end
