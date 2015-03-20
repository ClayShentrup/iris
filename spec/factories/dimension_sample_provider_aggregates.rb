# == Schema Information
#
# Table name: dimension_sample_provider_aggregates
#
#  id                  :integer          not null, primary key
#  socrata_provider_id :string           not null
#  dataset_id          :string           not null
#  column_name         :string           not null
#  value               :string           not null
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#

FactoryGirl.define do
  factory :dimension_sample_provider_aggregate,
          class: 'DimensionSample::ProviderAggregate' do
    dataset_id 'yq43-i98g'
    socrata_provider_id '010001'
    column_name 'domain_1_score'
    value '3.0000'
  end
end
