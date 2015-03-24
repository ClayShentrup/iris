module Socrata
  # Returns a new hash with the specified keys renamed.
  class RenameAttributes
    def self.call(attributes:, rename_hash:)
      updated_key_values = attributes.map do |original_key, value|
        updated_key = rename_hash.fetch(original_key, original_key)
        [updated_key, value]
      end
      Hash[updated_key_values]
    end
  end
end
