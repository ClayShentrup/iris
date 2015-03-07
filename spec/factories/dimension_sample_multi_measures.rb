# == Schema Information
#
# Table name: dimension_sample_multi_measures
#
#  id                  :integer          not null, primary key
#  socrata_provider_id :string           not null
#  measure_id          :string           not null
#  column_name         :string           not null
#  value               :string           not null
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  dataset_id          :string           not null
#

FactoryGirl.define do
  factory :dimension_sample_multi_measure,
          class: 'DimensionSample::MultiMeasure' do
    socrata_provider_id '010001'
    measure_id 'MORT_30_AMI'
    column_name 'denominator'
    value '350'
  end
end
