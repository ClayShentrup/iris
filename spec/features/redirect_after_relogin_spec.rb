require 'feature_spec_helper'

RSpec.feature 'Clicking a link after session expires' do
  it 'redirects to link target after signing back in' do
    log_in_user
    within_window(open_new_window) do
      visit root_path
      log_out
      page.driver.browser.close
    end
    visit metrics_path
    log_in_user
    expect(page).to have_content 'Public Data'
    expect(current_path).to eq metrics_path
  end
end
