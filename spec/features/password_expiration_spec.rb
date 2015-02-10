require 'feature_spec_helper'

RSpec.feature 'Password expires' do
  let!(:user) { create(:user) }
  let(:new_password) { 'flameindeedhighwaypiece' }

  def renew_password
    fill_in 'Current password', with: user.password
    fill_in 'New password', with: new_password
    fill_in 'Confirm new password', with: new_password
    click_button 'Change my password'
  end

  scenario 'password does not expire before 90 days' do
    Timecop.travel(90.day - 1.hour)
    log_in(user)
    visit metrics_path
    expect(current_path).to eq(metrics_path)
    log_out
    Timecop.return
  end

  scenario 'password expires after 90 days' do
    # We need an hour buffer here, most likely due to Daylight Savings
    Timecop.travel(90.day + 1.hour)
    log_in(user)
    expect(current_path).to eq(user_password_expired_path)

    renew_password
    expect(current_path).to eq(root_path)

    Timecop.return
  end
end
