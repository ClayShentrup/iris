require 'feature_spec_helper'

RSpec.feature 'Clicking a link after session expires' do
  let(:user) { create :user }
  let(:url) { '/metrics/public-data/hospital-acquired-conditions' }

  before { log_in user }

  it 'redirects to link target after signing back in' do
    visit url
    find('#measures_nav_container').click_link('Patient Safety Indicator')

    within_window(open_new_window) do
      visit root_path
      log_out
    end

    click_link 'Hospital-Acquired Conditions'
    expect(page).to have_text('Sign In')

    log_in user
    expect(current_path).to eq url
  end
end
