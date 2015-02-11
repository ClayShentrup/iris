require 'feature_spec_helper'

RSpec.feature 'Session inactivity' do
  let(:user) { create(:user) }

  background do
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Sign in'
  end

  scenario 'session expires after 15 minutes' do
    visit metrics_path
    expect(current_path).to eq(metrics_path)
    Timecop.travel(15.minutes)
    visit news_path
    expect(current_path).to eq(new_user_session_path)
  end
end
