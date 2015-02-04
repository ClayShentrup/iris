FactoryGirl.define do
  factory :dimension_multi_measures, class: 'Dimension::MultiMeasure' do
    provider_id '010001'
    measure_id 'MORT_30_AMI'
    column_name 'denominator'
    value '350'
  end
end
