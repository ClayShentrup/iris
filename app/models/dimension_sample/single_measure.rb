# == Schema Information
#
# Table name: dimension_sample_single_measures
#
#  id          :integer          not null, primary key
#  provider_id :string           not null
#  dataset_id  :string           not null
#  column_name :string           not null
#  value       :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require_relative '../dimension_sample'
module DimensionSample
  # Corresponds to a dataset like yq43-i98g, which has one line per provider.
  class SingleMeasure < ActiveRecord::Base
    validates :dataset_id, presence: true
    validates :provider_id, presence: true
    validates :column_name, presence: true
    validates :value, presence: true
  end
end
