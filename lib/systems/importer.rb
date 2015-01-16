require 'roo'

module Systems
  # Import Systems and associate hospital to them
  module Importer
    DATA_FILE = 'lib/hospital_systems.xls'
    SHEET = 'Hospital_General_Information (1'

    class << self
      def call
        hospital_systems = parse_file(DATA_FILE)
        hospital_systems.each do |data|
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

      def parse_file(filepath)
        data = Roo::Excel.new(filepath, file_warning: :ignore)
        result = []

        (2..data.last_row(SHEET)).each do |row|
          break if data.cell(row, 1, SHEET).blank?

          row_data = {
            system_name: data.cell(row, 1, SHEET),
            provider_id: data.cell(row, 2, SHEET).to_i.to_s.rjust(6, '0'),
          }
          result << row_data
        end

        result
      end
    end
  end
end
