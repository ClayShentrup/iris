require 'feature_spec_helper'

RSpec.feature 'Password expires' do
  let(:expire_password_after) { 90.days }
  let!(:user) do
    Timecop.travel(now) { create(User, :authenticatable, :with_associations) }
  end
  let(:new_password) { 'flameindeedhighwaypiece' }

  def renew_password
    fill_in 'New password', with: new_password
    click_button 'Create'
  end

  let(:now) { DateTime.parse('2008-11-05') }

  def log_in_just_before_expiration
    Timecop.travel(now + expire_password_after - 10.seconds) { log_in user }
  end

  def do_after_expiration(&block)
    Timecop.travel(now + expire_password_after + 1.second, &block)
  end

  scenario 'user is forced to change his/her password' do
    log_in_just_before_expiration
    expect(current_path).to eq root_path
    log_out
    do_after_expiration { log_in user }
    expect(current_path).to eq user_password_expired_path
    do_after_expiration { renew_password }
    expect(current_path).to eq root_path
  end
end
