require 'roo'

module HospitalSystems
  # Read the Excel file with information about systems and hospitals.
  # This class iterates all the systems and their associated hospitals.
  class DataFromSpreadsheet
    FILEPATH = 'lib/assets/files/hospital_systems.xls'
    HEADERS = {
      provider_id: 'Provider Number',
      system_name: 'System Name',
    }

    def self.call(*args)
      new(*args).call
    end

    def call
      data_rows.map do |row|
        {
          system_name: row.fetch(:system_name),
          provider_id: normalized_provider_id(row.fetch(:provider_id)),
        }
      end
    end

    private

    def file_data
      Roo::Spreadsheet.open(FILEPATH, file_warning: :ignore)
    end

    def data_rows
      all_rows_lazy.reject { |row| header?(row) }
    end

    def all_rows_lazy
      file_data.parse(HEADERS).lazy
    end

    def header?(row)
      row.fetch(:system_name) == 'System Name'
    end

    def normalized_provider_id(provider_id)
      provider_id_to_string(provider_id).rjust(6, '0')
    end

    def provider_id_to_string(provider_id)
      provider_id.is_a?(Numeric) ? provider_id.to_i.to_s : provider_id
    end
  end
end
