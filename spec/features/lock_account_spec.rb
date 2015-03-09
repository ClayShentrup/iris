require 'feature_spec_helper'

RSpec.feature 'Lock account' do
  let!(:user) { create(:user_for_controller_specs) }
  let!(:admin_user) { create(:dabo_admin) }
  let(:first_failed_attempt_message) do
    'Invalid email or password. ' \
    'You have one more try before we reset your login.'
  end
  let(:second_failed_attempt_message) do
    'Invalid email or password. ' \
    'We sent an e-mail with instructions on how to reset your password. ' \
    "#{user.email}"
  end

  def log_in_with_wrong_password
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: 'wrongpassword'
    click_button 'Login'
  end

  describe 'when a user incorrectly logs in' do
    it 'shows the first failed attempt message' do
      log_in_with_wrong_password
      expect(page).to have_content(first_failed_attempt_message)
    end

    it 'shows the second failed attempt message' do
      log_in_with_wrong_password
      log_in_with_wrong_password
      expect(page).to have_content(second_failed_attempt_message)
    end

    it 'locks account after 3 failed attempts, and can be unlocked' do
      log_in_with_wrong_password
      log_in_with_wrong_password
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
end
