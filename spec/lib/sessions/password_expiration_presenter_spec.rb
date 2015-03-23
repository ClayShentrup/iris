require 'rails_helper'

RSpec.describe Sessions::PasswordExpirationPresenter do
  subject { described_class.call(current_user, view_context) }
  let(:current_user) { create :user }
  let(:view_context) { instance_double 'view_context' }
  let(:update_password_path) { '<a href="/users/edit">update to a new one</a>' }
  let(:flash_message) do
    "#{current_user.first_name}, you have 3 days before your " \
    "password expires. Please #{update_password_path}."
  end

  before do
    allow(view_context).to receive(:link_to).and_return(update_password_path)
  end

  context 'when a user\'s password is about to expire' do
    it 'should return a message' do
      current_user.update_attribute(
        :password_changed_at, Time.current - 86.days
      )
      expect(subject).to eq(flash_message)
    end
  end

  context 'when a user\'s password is not about to expire' do
    it 'should not return a message' do
      expect(subject).to eq(nil)
    end
  end
end
