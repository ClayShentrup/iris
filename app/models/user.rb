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

require 'devise'
require 'devise/orm/active_record'
require 'devise_security_extension'
require './app/validators/password_strength_validator'
require './app/models/account'

# An entity to log into the system
class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :lockable, and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :lockable, :confirmable, :timeoutable, :password_expirable,
         :password_archivable

  belongs_to :account
  # Some validations are enforced through devise config.
  # See initializers/devise.rb for more information.
  validates :email, presence: true
  validates :is_dabo_admin, inclusion: { in: [true, false] }
  validates :password,
            password_strength: true,
            presence: true,
            unless: :updating_without_password?

  private

  def updating_without_password?
    password.nil? && encrypted_password.present?
  end
end
