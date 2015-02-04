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
#

require 'active_record_spec_helper'

require 'devise'
require 'devise/orm/active_record'

require './app/models/user'

RSpec.describe User, type: :model do
  describe 'columns' do
    it { is_expected.to have_db_column(:email).of_type(:string) }
    it do
      is_expected.to have_db_column(:is_dabo_admin).of_type(:boolean)
        .with_options(
          null: false,
          default: false,
        )
    end
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_exclusion_of(:is_dabo_admin).in_array([nil]) }
  end
end
