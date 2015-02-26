require 'feature_spec_helper'

RSpec.feature 'Change password' do
  let(:user) { create :user }
  let(:user_profiles_settings_url) { '/user_profiles/settings' }
  let(:new_password) { 'composedchosechargeproduce' }

  before do
    log_in user
    visit user_profiles_settings_url
    click_link 'Change password'
  end

  def renew_password
    fill_in 'Current password', with: user.password
    fill_in 'Password', with: new_password
    fill_in 'Password confirmation', with: new_password
    click_button 'Update'
  end

  scenario 'user can change password from user profiles' do
    renew_password
    expect(page).to have_content('Your account has been updated successfully.')
  end
end
