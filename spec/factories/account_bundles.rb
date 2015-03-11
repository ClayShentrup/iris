require './app/models/account_bundle'

FactoryGirl.define do
  factory :account_bundle do
    association :account
    bundle_id 'some-bundle-id'
  end
end
