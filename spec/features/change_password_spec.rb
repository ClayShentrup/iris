require 'feature_spec_helper'

RSpec.feature 'Change password' do
  let(:user) { create :user }
  let(:new_password) { 'composedchosechargeproduce' }

  before do
    log_in user
    visit user_profiles_settings_path
    click_link 'Change password'
  end

  scenario 'user can change password from user profiles' do
    fill_in 'Current password', with: user.password
    fill_in 'Password', with: new_password
    fill_in 'Password confirmation', with: new_password
    click_button 'Update'
    expect(page).to have_content('Your account has been updated successfully.')
  end
end
