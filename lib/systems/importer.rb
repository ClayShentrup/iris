require_relative 'iterator'

module Systems
  # Import Systems and associate hospital to them
  module Importer
    class << self
      def call(file_path)
        Iterator.new(file_path).each do |data|
          next unless data.fetch(:system_name)

          system = HospitalSystem.find_or_create_by!(
            name: data.fetch(:system_name),
          )
          hospital = Hospital.find_by_provider_id(data.fetch(:provider_id))

          associate_system_with_hospital(system, hospital) if hospital
          yield if block_given?
        end
      end

      private

      def associate_system_with_hospital(system, hospital)
        hospital.update_attributes!(hospital_system: system)
      end
    end
  end
end
