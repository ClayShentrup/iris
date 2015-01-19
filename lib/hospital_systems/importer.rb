require_relative 'iterator'

module HospitalSystems
  # Import Hospital systems and associate hospital to them
  module Importer
    class << self
      def call(file_path)
        Iterator.new(file_path).each do |data|
          system = find_hospital_system(data.fetch(:system_name))
          hospital = Hospital.find_by_provider_id(data.fetch(:provider_id))

          if hospital
            associate_system_with_hospital(system, hospital)
          else
            message = 'Hospital not found: '\
              "Provider id ##{data.fetch(:provider_id)}"
          end

          yield message if block_given?
        end
      end

      private

      def find_hospital_system(name)
        HospitalSystem.find_or_create_by!(name: name) if name
      end

      def associate_system_with_hospital(system, hospital)
        hospital.update_attributes!(hospital_system: system)
      end
    end
  end
end
