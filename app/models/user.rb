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
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  failed_attempts        :integer          default(0), not null
#  unlock_token           :string
#  locked_at              :datetime
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string
#  is_dabo_admin          :boolean          default(FALSE), not null
#  account_id             :integer
#  password_changed_at    :datetime
#  unique_session_id      :string(20)
#  first_name             :string           not null
#  last_name              :string           not null
#  selected_provider_id   :integer
#  selected_context       :string
#

require 'devise'
require 'devise/orm/active_record'
require 'devise_security_extension'
require 'rails-settings-cached'
require './app/validators/password_strength_validator'
require './app/models/account'

# An entity to log into the system
class User < ActiveRecord::Base
  DEFAULT_CONTEXT = 'city'
  # Include default devise modules. Others available are:
  # :lockable, and :omniauthable
  devise :confirmable,
         :database_authenticatable,
         :lockable,
         :password_archivable,
         :password_expirable,
         :recoverable,
         :registerable,
         :rememberable,
         :session_limitable,
         :timeoutable,
         :trackable

  belongs_to :account
  has_many :purchased_metric_modules

  belongs_to :selected_provider, class_name: 'Provider'

  # Some validations are enforced through devise config.
  # See initializers/devise.rb for more information.
  validates :email, presence: true, uniqueness: true
  validates :account, presence: true,
                      unless: :skip_association_presence_validations
  validates :is_dabo_admin, inclusion: { in: [true, false] }
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :password,
            password_strength: true,
            presence: true,
            length: { minimum: 8 },
            unless: :updating_without_password?

  delegate :default_provider, to: :account
  delegate :purchased_metric_modules, to: :account

  attr_accessor :skip_association_presence_validations

  def selected_provider
    super || default_provider
  end

  def selected_context
    super || DEFAULT_CONTEXT
  end

  private

  def updating_without_password?
    password.nil? && encrypted_password.present?
  end
end
