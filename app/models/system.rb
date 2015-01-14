# Represents a system entity
class System < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
  has_many :hospitals

  def self.create_or_update(attributes)
    find_or_initialize_by(name: attributes.fetch('name'))
      .update_attributes!(attributes)
  end
end
