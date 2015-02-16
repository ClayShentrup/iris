require 'feature_spec_helper'

RSpec.feature 'Session inactivity' do
  let(:session_start) { DateTime.parse('2008-11-05') }
  let(:timeout_in) { 15.minutes }

  let(:about_to_expire) { now + 15.minutes - 1.second }
  let(:expired) { now + 15.minutes }

  background do
    Timecop.freeze(session_start) { log_in_user }
    Timecop.freeze(session_start + refresh_delay) { visit root_path }
  end

  feature 'just before session timeout' do
    given(:refresh_delay) { timeout_in - 1.second }

    scenario 'session is not expired before 15 minutes' do
      expect(current_path).to eq root_path
    end
  end

  feature 'at session timeout' do
    given(:refresh_delay) { timeout_in }

    scenario 'session is not expired before 15 minutes' do
      expect(current_path).to eq new_user_session_path
    end
  end
end
