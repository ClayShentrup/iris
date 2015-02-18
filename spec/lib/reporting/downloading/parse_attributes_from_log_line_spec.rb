require 'active_record_no_rails_helper'
require 'reporting/downloading/parse_attributes_from_log_line'

RSpec.describe Reporting::Downloading::ParseAttributesFromLogLine do
  let(:log_line) do
    %W(
      #{logged_at}
      heroku[router]:
      at=info
      method=GET
      path="#{path}"
      host=mayo-act-acceptance-76893540.herokuapp.com
      request_id=#{heroku_request_id}
      fwd="199.192.87.174"
      dyno=web.1
      connect=1ms
      service=3ms
      status=304
      bytes=1265
    ).join(' ')
  end
  let(:logged_at) { '2014-09-08T23:11:14.780027+00:00' }
  let(:heroku_request_id) { '0f1e5956-de1b-41bf-b080-baec304fc04b' }
  let(:path) do
    URI.parse('/assets/pixel-622523d3ac0db3a95a9149d6bdc5e79c.gif').tap do |uri|
      uri.query = query
    end
  end
  let(:query) do
    {
      data: data.to_json,
    }.to_query
  end
  let(:data) do
    {
      'event' => 'New User Got Excited',
      'properties' => {
        'user_id' => 42,
      },
    }
  end

  it 'saves a new log line' do
    expect(described_class.call(log_line)).to eq(
      heroku_request_id: heroku_request_id,
      logged_at: logged_at,
      data: data,
    )
  end
end
