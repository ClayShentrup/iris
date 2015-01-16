require 'roo'

module Systems
  # Read the Excel file with information about systems and hospitals.
  # This class iterates all the systems and their associated hospitals.
  class Iterator
    include Enumerable

    def initialize(filepath)
      @filepath = filepath
    end

    def each
      (2..file_data.last_row).each do |row|
        break if file_data.cell(row, 1).blank?

        row_data = {
          system_name: file_data.cell(row, 1),
          provider_id: file_data.cell(row, 2).to_i.to_s.rjust(6, '0'),
        }

        yield row_data
      end
    end

    private

    def file_data
      @file_data ||= Roo::Excel.new(@filepath, file_warning: :ignore)
    end
  end
end
