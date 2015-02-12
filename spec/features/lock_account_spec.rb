require 'feature_spec_helper'

RSpec.feature 'Lock account' do
  let!(:user) { create(:user) }
  let!(:admin_user) { create(:user, :dabo_admin) }

  def log_in_with_wrong_password
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: 'wrongpassword'
    click_button 'Sign in'
  end

  scenario 'account does not lock after 2 failed attempts' do
    log_in_with_wrong_password
    log_in_with_wrong_password
    log_in(user)
    expect(current_path).to eq(root_path)
  end

  scenario 'account locks after 3 failed attempts' do
    log_in_with_wrong_password
    log_in_with_wrong_password
    expect(page).to have_content(
      'You have one more attempt before your account is locked.',
    )

    log_in_with_wrong_password
    expect(page).to have_content 'Your account is locked.'
    log_in(user)
    expect(current_path).to eq(new_user_session_path)
  end

  scenario 'admin can unlock a locked user' do
    user.lock_access!

    log_in(admin_user)
    visit edit_dabo_admin_user_path(user)
    expect(page).to have_button('Unlock')
    click_button('Unlock')
    expect(page).not_to have_button('Unlock')
    log_out

    log_in(user)
    expect(current_path).to eq(root_path)
  end
end
