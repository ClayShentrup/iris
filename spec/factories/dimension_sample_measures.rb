# == Schema Information
#
# Table name: dimension_sample_measures
#
#  id                  :integer          not null, primary key
#  socrata_provider_id :string           not null
#  measure_id          :string           not null
#  value               :string           not null
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#

FactoryGirl.define do
  factory :dimension_sample_measure,
          class: 'DimensionSample::Measure' do
    measure_id 'MORT_30_AMI'
    socrata_provider_id '010001'
    value '350'
  end
end
