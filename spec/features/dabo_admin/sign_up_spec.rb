require 'feature_spec_helper'

RSpec.feature 'Sign up with or without an account' do
  let(:account) { create Account }
  let(:domain_name) { 'foo.com' }
  let(:email_address) { "foo@#{domain_name}" }
  let(:valid_password) { 'testingtestingtesting' }

  def attempt_sign_up
    visit new_user_registration_path
    fill_in 'Given Name', with: 'Givenname'
    fill_in 'Surname', with: 'Surname'
    fill_in 'Hospital Email', with: email_address
    fill_in 'Password', with: valid_password
    click_button 'Join'
  end

  context 'user\'s domain does not match existing account' do
    before do
      attempt_sign_up
    end
    it 'does not create a user and shows error message' do
      expect { attempt_sign_up }.not_to change { User.count }
      expect(page).to have_content(
        'Email address is not associated with a ' \
        'registered account.',
      )
    end
  end

  context 'user\'s domain matches existing account' do
    before do
      create(AuthorizedDomain, name: domain_name, account: account)
      attempt_sign_up
    end
    it 'creates the user and shows thank you message' do
      expect(page).to have_content('Thank you for joining')
      expect(User.last.email).to eq email_address
    end
  end
end
