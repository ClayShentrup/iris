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

require 'ipaddr'

FactoryGirl.define do
  factory :user do
    skip_association_presence_validations
    confirmed
    sequence(:email) { |n| "user#{n}@factory.com" }
    sequence(:first_name) { |n| "Firstname#{n}" }
    sequence(:last_name) { |n| "Lastname#{n}" }
    password 'password123'

    trait :dabo_admin do
      is_dabo_admin true
      authenticatable
    end

    trait :with_devise_session do
      current_sign_in_at Time.now
      current_sign_in_ip IPAddr.new
    end

    trait :authenticatable do
      with_devise_session
    end

    trait :confirmed do
      before(:create, &:skip_confirmation!)
    end

    trait :with_associations do
      association :account, :with_associations
      association :selected_provider, :with_associations, factory: :provider
    end
  end
end
