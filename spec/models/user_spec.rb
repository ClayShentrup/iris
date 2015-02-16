# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default("0"), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  failed_attempts        :integer          default("0"), not null
#  unlock_token           :string
#  locked_at              :datetime
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string
#  is_dabo_admin          :boolean          default("false"), not null
#  account_id             :integer
#

require 'active_record_spec_helper'
require './app/models/user'

RSpec.describe User, type: :model do
  describe 'columns' do
    specify do
      is_expected.to have_db_column(:email).of_type(:string)
        .with_options(null: false)
    end
    specify do
      is_expected.to have_db_column(:is_dabo_admin).of_type(:boolean)
        .with_options(null: false)
    end
  end

  describe 'validations' do
    specify { is_expected.to validate_presence_of(:email) }
    specify { is_expected.to allow_value(false).for(:is_dabo_admin) }
    specify { is_expected.not_to allow_value(nil).for(:is_dabo_admin) }
  end

  it { is_expected.to belong_to :account }
end
