# An example of a minimal, well tested CRUD model
class PristineExample < ActiveRecord::Base
  validates :name, presence: true
end
