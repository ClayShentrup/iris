require 'feature_spec_helper'

RSpec.feature 'Logging in' do
  let(:user) { create :user }
  let(:session_one) { create_session }
  let(:session_two) { create_session }
  let(:flash_message) do
    <<-FLASH_MESSAGE
      Your login credentials were used in another browser. Please sign in again
      to continue in this browser.
    FLASH_MESSAGE
  end

  def create_session
    Capybara::Session.new(Capybara.default_driver, Capybara.app)
  end

  def log_in_session(session)
    session.visit new_user_session_path
    session.fill_in 'Email', with: user.email
    session.fill_in 'Password', with: user.password
    session.click_button 'Sign in'
    expect(session.current_path).to eq root_path
  end

  it 'displays a flash message and signs out first session' do
    log_in_session(session_one)
    log_in_session(session_two)
    session_one.visit new_user_session_path
    expect(session_one.current_path).to eq new_user_session_path
    expect(session_one).to have_content flash_message
  end
end
