# Helper to authenticate using Capybara
module AuthenticationHelpers
  def log_in(user)
    visit new_user_session_path
    fill_in 'Hospital Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Login'
  end

  def log_in_user
    log_in(create(:user))
  end

  def log_out
    click_link 'Logout'
  end
end
