require 'rails_helper'

RSpec.describe DaboAdmin::ReportsController do
  login_admin

  describe 'GET show' do
    let(:report_and_date) do
      {
        date: Date.parse('2014-04-21'),
        report: report,
      }
    end

    let(:report) do
      {
        foo: 'bar',
      }
    end

    def execute_request
      get :index, params
    end

    before do
      allow(Reporting::ReportFetcher).to receive(:call).with(
        report_date_string: user_selected_date_string,
        report_class: Reporting::DailyPageViewMetricsReport,
        ).and_return(report_and_date)
      execute_request
    end

    context 'no date specified' do
      let(:params) { {} }
      let(:user_selected_date_string) { nil }

      it 'returns a report object with no user date provided' do
        expect(assigns(:report)).to be report
      end
    end

    context 'date specified with datepicker' do
      let(:params) { { logged_at: user_selected_date_string } }
      let(:user_selected_date_string) { '2014-04-20' }

      it 'uses a report for the specified date' do
        expect(assigns(:report)).to be report
      end
    end
  end
end
