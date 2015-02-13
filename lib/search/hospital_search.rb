# Searches hospitals
module Search
  HospitalSearch = Struct.new(:query) do
    def self.call(*args)
      new(*args).call
    end

    def call
      Hospital.search_by_name(query)
    end
  end
end
