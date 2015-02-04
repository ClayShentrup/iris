# Defines the namespace for related dimension models. Required by ActiveRecord.
module Dimension
  def self.table_name_prefix
    'dimension_'
  end
end
