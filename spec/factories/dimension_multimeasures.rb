FactoryGirl.define do
  factory :dimension_multimeasure, class: 'Dimension::Multimeasure' do
    provider nil
    measure_id 'MORT_30_AMI'
    column_name 'denominator'
    value '350'
  end
end
