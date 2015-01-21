require 'roo'

module HospitalSystems
  # Read the Excel file with information about systems and hospitals.
  # This class iterates all the systems and their associated hospitals.
  class Iterator
    include Enumerable

    def initialize(file_path: fail)
      @file_path = file_path
    end

    def each
      file_data.parse(headers) do |row|
        next if header?(row)

        hospital_systems_data = {
          system_name: row.fetch(:system_name),
          provider_id: normalized_provider_id(row),
        }
        yield hospital_systems_data
      end
    end

    private

    def file_data
      @file_data ||= Roo::Spreadsheet.open(@file_path, file_warning: :ignore)
    end

    def headers
      { system_name: 'System Name', provider_id: 'Provider Number' }
    end

    def header?(row)
      row.fetch(:system_name) == 'System Name'
    end

    def normalized_provider_id(row)
      format('%06d', row.fetch(:provider_id).to_i)
    end
  end
end
