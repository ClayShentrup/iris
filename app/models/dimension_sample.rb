# == Schema Information
#
# Table name: dimension_samples
#
#  id                   :integer          not null, primary key
#  socrata_provider_id  :string
#  dimension_identifier :string
#  value                :float
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#

# A dimension sample is the most granular data value used in creating charts. A
# dimension sample value is either the raw value (e.g. score) from CMS or a
# derived value that we calculate.
class DimensionSample < ActiveRecord::Base
  validates :dimension_identifier, presence: true
  validates :socrata_provider_id, presence: true
  validates :value, presence: true, numericality: true
  validates :socrata_provider_id, uniqueness: { scope: :dimension_identifier }
end
