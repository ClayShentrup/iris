require 'feature_spec_helper'

RSpec.feature 'Session inactivity' do
  let(:session_start) { DateTime.parse('2008-11-05') }
  let(:timeout_in) { 15.minutes }

  background do
    Timecop.freeze(session_start) { log_in_user }
    Timecop.travel(session_start + refresh_delay) do
      visit metrics_path
      wait_for_page_to_load
    end
  end

  def wait_for_page_to_load
    expect(page).to have_content expected_next_page_content
  end

  feature 'just before session timeout' do
    given(:refresh_delay) { timeout_in - 1.seconds   }
    let(:expected_next_page_content) { 'Public Data' }

    scenario 'session is not expired before 15 minutes' do
      expect(current_path).to eq metrics_path
    end
  end

  feature 'at session timeout' do
    given(:refresh_delay) { timeout_in }
    let(:expected_next_page_content) do
      'Your session expired. Please sign in again to continue.'
    end

    scenario 'session is expired after 15 minutes' do
      expect(current_path).to eq new_user_session_path
    end
  end
end
