require './app/models/provider'
require './app/models/hospital_system'
require_relative 'data_from_spreadsheet'

# Import Hospital systems and associate providers to them
module HospitalSystems
  Importer = Struct.new(:data) do
    def self.call
      DataFromSpreadsheet.call.map { |data| new(data).call }
    end

    def call
      if provider_exists_in_our_database?
        associate_provider_with_system
        nil
      else
        "Provider not found: ##{data.fetch(:socrata_provider_id)}"
      end
    end

    def provider_exists_in_our_database?
      provider.present?
    end

    def provider
      Provider.find_by(socrata_provider_id: data.fetch(:socrata_provider_id))
    end

    def associate_provider_with_system
      provider.update_attributes!(hospital_system: hospital_system)
    end

    def hospital_system
      return unless system_name.present?
      HospitalSystem.find_or_create_by!(name: system_name)
    end

    def system_name
      data.fetch(:system_name)
    end
  end
end
