# Helper to authenticate using Capybara
module AuthenticationHelpers
  def log_in(user)
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Sign in'
  end

  def log_out
    click_link 'Sign out'
  end
end
