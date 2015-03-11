require 'rails_helper'

RSpec.describe SessionsPresenter do
  subject { described_class.new(params, flash) }
  let(:flash) { instance_double ActionDispatch::Flash::FlashHash }
  let(:flash_message) { 'Invalid email or password' }

  def check_reset_password_message(expected_value)
    expect(subject.reset_password_message?).to be expected_value
  end

  def check_css(expected_value)
    expect(subject.css_class).to eq expected_value
  end

  before do
    allow(flash).to receive(:alert).and_return(flash_message)
  end

  context 'when a user visits the sign in page for the first time' do
    let(:flash_message) { '' }
    let(:params) do
      {
        controller: 'users/sessions',
        action: 'new',
      }
    end

    it 'returns false for reset_password_message? and no CSS class name' do
      check_reset_password_message(false)
      check_css(nil)
    end
  end

  context 'when a user submits an invalid email address' do
    let(:params) do
      {
        controller: 'users/sessions',
        action: 'create',
        'user' => {
          'email' => 'donald.draper@scdp.com',
          'password' => 'thisismypasswordok!',
        },
      }
    end

    it 'returns false for reset_password_message? and correct CSS class name' do
      check_reset_password_message(false)
      check_css('field_with_errors')
    end
  end

  context 'when a user submits the incorrect password for second time' do
    let(:user) { create :user }
    let(:params) do
      {
        controller: 'users/sessions',
        action: 'create',
        'user' => {
          'email' => user.email,
          'password' => 'thisismypasswordok!',
        },
      }
    end

    before do
      user.update_attribute(:failed_attempts, 2)
    end

    it 'returns true for reset_password_message? and correct CSS class name' do
      check_reset_password_message(true)
      check_css('field_with_errors')
    end
  end
end
