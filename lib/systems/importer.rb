require_relative 'iterator'

module Systems
  # Import Systems and associate hospital to them
  module Importer
    DATA_FILE = 'lib/hospital_systems.xls'

    class << self
      def call
        Iterator.new(DATA_FILE).each do |data|
          system = HospitalSystem.find_or_create_by!(
            name: data.fetch(:system_name),
          )
          hospital = Hospital.find_by_provider_id(data.fetch(:provider_id))

          associate_system_with_hospital(system, hospital) if hospital
        end
      end

      private

      def associate_system_with_hospital(system, hospital)
        hospital.update_attributes!(hospital_system: system)
      end
    end
  end
end
