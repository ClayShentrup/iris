require_relative 'data_from_spreadsheet'

# Import Hospital systems and associate hospital to them
module HospitalSystems
  Importer = Struct.new(:data) do
    def self.call
      DataFromSpreadsheet.call.map { |data| new(data).call }
    end

    def call
      if hospital_exists_in_our_database?
        associate_hospital_with_system
        nil
      else
        "Hospital not found: Provider id ##{data.fetch(:provider_id)}"
      end
    end

    def hospital_exists_in_our_database?
      hospital.present?
    end

    def hospital
      Hospital.find_by(provider_id: data.fetch(:provider_id))
    end

    def associate_hospital_with_system
      hospital.update_attributes!(hospital_system: hospital_system)
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
