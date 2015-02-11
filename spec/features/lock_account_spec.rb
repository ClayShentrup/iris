require 'feature_spec_helper'

RSpec.feature 'Lock account' do
  let!(:user) { create(:user) }

  def sign_in_with_wrong_password
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: 'wrongpassword'
    click_button 'Sign in'
  end

  def sign_in
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Sign in'
  end

  scenario 'account does not lock after 2 failed attempts' do
    sign_in_with_wrong_password
    sign_in_with_wrong_password
    sign_in
    expect(current_path).to eq(root_path)
  end

  scenario 'account locks after 3 failed attempts' do
    sign_in_with_wrong_password
    sign_in_with_wrong_password
    expect(page).to have_content(
      'You have one more attempt before your account is locked.',
    )

    sign_in_with_wrong_password
    expect(page).to have_content 'Your account is locked.'
    sign_in
    expect(current_path).to eq(new_user_session_path)
  end
end
