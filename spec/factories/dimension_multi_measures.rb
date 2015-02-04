FactoryGirl.define do
  factory :dimension_sample_multi_measures,
          class: 'DimensionSample::MultiMeasure' do
    provider_id '010001'
    measure_id 'MORT_30_AMI'
    column_name 'denominator'
    value '350'
  end
end
