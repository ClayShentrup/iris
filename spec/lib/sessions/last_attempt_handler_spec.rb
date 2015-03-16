require 'rails_helper'
require 'email_spec'
require 'sessions/last_attempt_handler'

RSpec.describe Sessions::LastAttemptHandler do
  include(EmailSpec::Helpers)
  include(EmailSpec::Matchers)

  subject { described_class.new(user_email) }

  def check_reset_password_message(expected_value)
    expect(subject.last_attempt?).to be expected_value
  end

  context 'when a user visits the sign in page for the first time' do
    let(:user_email) { nil }

    it 'returns false for last_attempt?' do
      check_reset_password_message(false)
    end
  end

  context 'when a user submits an invalid email address' do
    let(:user_email) { 'donald.draper@scdp.com' }

    it 'returns false for last_attempt?' do
      check_reset_password_message(false)
    end
  end

  context 'when a user submits the incorrect password for second time' do
    let(:user) { create :user, failed_attempts: 2 }
    let(:user_email) { user.email }
    let(:email) { open_email(user.email) }

    it 'returns true for last_attempt?' do
      check_reset_password_message(true)
    end

    it 'sends reset password email' do
      subject.send_reset_password_instructions_if_last_attempt
      expect(email).to deliver_to(user_email)
      expect(email).to have_subject('Reset Dabo Password - Action Required')
    end
  end
end
