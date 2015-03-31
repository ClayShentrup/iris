FactoryGirl.define do
  trait :skip_association_presence_validations do
    callback(:after_stub, :after_build) do |model|
      model.skip_association_presence_validations = true
    end
  end
end
