require 'feature_spec_helper'

RSpec.feature 'Login validation' do
  let!(:user) { create(User, :authenticatable, :with_associations) }
  let!(:admin_user) { create(User, :dabo_admin) }
  let(:first_failed_attempt_message) do
    'Invalid email or password. ' \
    'You have one more try before we reset your login.'
  end
  let(:second_failed_attempt_message) do
    'Invalid email or password. ' \
    'We sent an e-mail with instructions on how to reset your password. ' \
    "#{user.email}"
  end
  let(:incorrect_email_password_message) do
    'Invalid email or password. ' \
    'Please make sure you are using a hospital email.'
  end

  let(:email_field) { '.email_field' }
  let(:password_field) { '.password_field' }

  def log_in_with_wrong_credentials(email: user.email)
    visit new_user_session_path
    fill_in 'Hospital Email', with: email
    fill_in 'Password', with: 'wrongpassword'
    click_button 'Login'
  end

  def check_input_field_on_error_styling
    within find('form#new_user') do
      expect(page).to have_css('.email_field.field_with_errors')
      expect(page).to have_css('.password_field.field_with_errors')
    end
  end

  describe 'when a invalid user attempts to login' do
    it 'returns an incorrect email or password message' do
      log_in_with_wrong_credentials(email: 'foo@bar.com')
      expect(page).to have_content(incorrect_email_password_message)
      check_input_field_on_error_styling
    end
  end

  describe 'when a valid user incorrectly logs in' do
    it 'shows the first failed attempt message' do
      log_in_with_wrong_credentials
      expect(page).to have_content(first_failed_attempt_message)
      check_input_field_on_error_styling
    end

    it 'shows second failed attempt message and sends reset password email' do
      log_in_with_wrong_credentials
      log_in_with_wrong_credentials
      expect(page).to have_content(second_failed_attempt_message)
    end

    it 'locks account after 3 failed attempts, and can be unlocked' do
      log_in_with_wrong_credentials
      log_in_with_wrong_credentials
      log_in_with_wrong_credentials
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
