require 'feature_spec_helper'

RSpec.feature 'Lock account' do
  let!(:user) { create(:user_for_controller_specs) }
  let!(:admin_user) { create(:dabo_admin) }

  def log_in_with_wrong_password
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: 'wrongpassword'
    click_button 'Sign in'
  end

  background do
    log_in_with_wrong_password
    log_in_with_wrong_password
  end

  scenario 'account is not locked after only 2 failed attempts' do
    expect(page).to have_content(
      'You have one more attempt before your account is locked.',
    )
    log_in(user)
    expect(current_path).to eq root_path
  end

  scenario 'account locks after 3 failed attempts, and can be unlocked' do
    log_in_with_wrong_password
    log_in(user)
    expect(page).to have_content 'Your account is locked.'
    expect(current_path).to eq new_user_session_path

    log_in(admin_user)
    visit edit_dabo_admin_user_path(user)
    click_button 'Unlock'
    expect(page).not_to have_button 'Unlock'
    log_out

    log_in(user)
    expect(current_path).to eq root_path
  end
end
