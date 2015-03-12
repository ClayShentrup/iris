require 'feature_spec_helper'

RSpec.feature 'Password expires' do
  let(:expire_password_after) { 90.days }
  let!(:user) { Timecop.freeze(now) { create(:user) } }
  let(:new_password) { 'flameindeedhighwaypiece' }

  def renew_password
    fill_in 'Current password', with: user.password
    fill_in 'New password', with: new_password
    fill_in 'Confirm new password', with: new_password
    click_button 'Change my password'
  end

  let(:now) { DateTime.parse('2008-11-05') }

  def do_after_expiration(&block)
    Timecop.freeze(now + expire_password_after + 1.second, &block)
  end

  background do
    Timecop.freeze(now + expire_password_after) { log_in user }
    resize_to(:desktop)
  end

  scenario 'user is forced to change his/her password' do
    expect(current_path).to eq root_path
    log_out
    do_after_expiration { log_in user }
    expect(current_path).to eq user_password_expired_path
    do_after_expiration { renew_password }
    expect(current_path).to eq root_path
  end
end
